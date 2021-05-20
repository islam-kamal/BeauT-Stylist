import 'dart:convert';

import 'package:BeauT_Stylist/Base/AllTranslation.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/AppLoader.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/EmptyItem.dart';
import 'package:BeauT_Stylist/helpers/shared_preference_manger.dart';
import 'package:BeauT_Stylist/models/home_page_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../NetWorkUtil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getHomeData();
    super.initState();
  }

  HomePageResponse data = HomePageResponse();
  bool isLoading = true;

  void getHomeData() async {
    print("getting Cats");
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util
        .post("beautician/home/beautician-revenue?lang=en", headers: headers);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        data = HomePageResponse.fromJson(json.decode(response.toString()));
        isLoading = false;
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(
              "assets/images/header.png",
              fit: BoxFit.contain,
              width: 100,
              height: 30,
            )),
        body: isLoading == true
            ? AppLoader()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  VisitsHeader(
                      "${allTranslations.text("confirmed_order_number")}",
                      data.data.confirmedOrderNumber,
                      "num"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header("${allTranslations.text("total_win")}",
                          data.data.totalRevenue, "sar"),
                      Header("${allTranslations.text("rest")}",
                          data.data.totalRevenue, "sar"),
                    ],
                  ),
                  Text(
                    "${allTranslations.text("orders_list")}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                data.data.orders.length==0 ? EmptyItem(text: allTranslations.text("no_requests"),):  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.data.orders.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey[200])),
                          // height: MediaQuery.of(context).size.height / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "# ${data.data.orders[index].id}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                orderLayer(
                                    Icons.person,
                                    data.data.orders[index].userName ??
                                        " كريم طه"),
                                Row(
                                  children: [
                                    orderLayer(Icons.calendar_today,
                                        data.data.orders[index].date),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    orderLayer(Icons.timer,
                                        data.data.orders[index].time),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${allTranslations.text("status")}   :       "),
                                    Text(
                                        "${data.data.orders[index].paymentStatus} "),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${allTranslations.text("service_address")}   : "),
                                    Text(
                                        "${data.data.orders[index].locationType} "),
                                  ],
                                ),
                                Text(
                                  allTranslations.text("services"),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        data.data.orders[index].services.length,
                                    itemBuilder: (context, indexx) {
                                      return Row(
                                        children: [
                                          Icon(
                                            Icons.label,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "${data.data.orders[index].services[indexx].name}   ,  ${data.data.orders[indexx].services[indexx].personNum}   ${allTranslations.text("person")}  , ${data.data.orders[indexx].services[indexx].price}  ${allTranslations.text("sar")}",
                                              style: TextStyle(),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ));
  }

  Widget orderLayer(IconData icon, String hint) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(hint),
        )
      ],
    );
  }

  Widget Header(String lable, int value, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
     //   width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.width /4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.grey[100],
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Center(child: Icon(Icons.attach_money_outlined)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "${lable}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${value} ${type == "sar" ? allTranslations.text("sar") : allTranslations.text("visite")}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget VisitsHeader(String lable, int value, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,),
      child: Container(
        height: MediaQuery.of(context).size.width/3.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "${lable}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "${value}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          type == "sar"
                              ? allTranslations.text("sar")
                              : allTranslations.text("visite"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}

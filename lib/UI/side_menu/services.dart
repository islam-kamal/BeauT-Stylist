import 'dart:convert';
import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/Bolcs/getServicesBloc.dart';
import 'package:butyprovider/UI/CustomWidgets/AppLoader.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/UI/bottom_nav_bar/main_page.dart';
import 'package:butyprovider/UI/side_menu/add_service.dart';
import 'package:butyprovider/UI/side_menu/edit_service.dart';
import 'package:butyprovider/helpers/appEvent.dart';
import 'package:butyprovider/helpers/appState.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/categories_response.dart';
import 'package:butyprovider/models/services_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../NetWorkUtil.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String cat_name;
  @override
  void initState() {
    getServicesBloc.add(Hydrate());
    super.initState();
  }

  void deleteImage(int id, Function onDone) async {
    showLoadingDialog(context);
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);

    FormData formData = FormData.fromMap(
        {"lang": allTranslations.currentLanguage, "service_id": id});
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("beautician/services/destroy",
        body: formData, headers: headers);
    print(response.statusCode);
    if (response.data["status"] != false) {
      onDone();
    } else {
      print("ERROR");
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print(response.data.toString());
    }
  }

  CategoriesResponse ress = CategoriesResponse();

  void getCats() async {
    print("getting Cats");
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.get("beautician/categories/get-categories",
        headers: headers);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = CategoriesResponse.fromJson(json.decode(response.toString()));
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  Widget categoriesWidgets() {
    return InkWell(
      onTap: () {
        CustomSheet(
            context: context,
            widget: ListView.builder(
                itemCount: ress.categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            cat_name = ress.categories[index].name;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          ress.categories[index].name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider()
                    ],
                  );
                }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cat_name ?? " ${allTranslations.text("choose_cat")}"),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: allTranslations.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                                index: 0,
                              )));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            centerTitle: true,
            title: Text(
              allTranslations.text("services"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: BlocListener<GetServicesBloc, AppState>(
          bloc: getServicesBloc,
          listener: (context, state) {},
          child: BlocBuilder(
              bloc: getServicesBloc,
              builder: (context, state) {
                var date = state.model as ServicesResponse;

                return date == null
                    ? AppLoader()
                    : ListView(

                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.menu,
                                    size: 25,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    allTranslations.text("category"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          categoriesWidgets(),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  allTranslations.text("services"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddService()));
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.add_circle,
                                          size: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        allTranslations.text("add_services"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              itemCount: date.services.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            allTranslations.currentLanguage ==
                                                    "ar"
                                                ? date.services[index].nameAr
                                                : date.services[index].nameEn,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${date.services[index].price} ${allTranslations.text("sar")}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditService(
                                                                services:
                                                                    date.services[
                                                                        index],
                                                              )));
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: Colors.grey[500],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: Text(
                                                        allTranslations
                                                            .text("edit"),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[500]),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              allTranslations.currentLanguage ==
                                                      "ar"
                                                  ? date
                                                      .services[index].detailsAr
                                                  : date.services[index]
                                                      .detailsEn,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${date.services[index].estimatedTime} ${allTranslations.text("min")}"),
                                                InkWell(
                                                  onTap: () {
                                                    deleteImage(
                                                        date.services[index].id,
                                                        () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        date.services
                                                            .removeAt(index);
                                                      });
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.delete,
                                                          size: 20,
                                                          color: Colors.red),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: Text(
                                                          allTranslations
                                                              .text("delete"),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                );
                              }),
                        ],
                      );
              }),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/UI/CustomWidgets/AppLoader.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/on_done_dialog.dart';
import 'package:butyprovider/UI/bottom_nav_bar/EditTimee.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/beautician_schedule.dart';
import 'package:butyprovider/models/dayes_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../NetWorkUtil.dart';
import 'Appointments.dart';

class BeauticanTimes extends StatefulWidget {
  @override
  _BeauticanTimesState createState() => _BeauticanTimesState();
}

class _BeauticanTimesState extends State<BeauticanTimes>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  List<Days> days = [];
  BeauticianScheduleResponse timesRespone = BeauticianScheduleResponse();
  bool isLoading = true;

  void getData() async {
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
        .get("beautician/work-schedule/beautician_schedule", headers: headers);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        timesRespone = BeauticianScheduleResponse.fromJson(
            json.decode(response.toString()));

        isLoading = false;
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Appointments()));
        },
        child: Container(
          width: 50,
          height: 50,
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, shape: BoxShape.circle),
        ),
      ),
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
          : AnimationLimiter(
              child: ListView.builder(
                itemCount: timesRespone.schedule.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 375.0,
                      child: dayItem(index),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget dayItem(int index) {
    return InkWell(
      onTap: () {
        CustomSheet(
            context: context,
            hight: MediaQuery.of(context).size.height / 3,
            widget: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    deleteImage(timesRespone.schedule[index].id, index);
                  },
                  child: Text(
                    allTranslations.text("delete"),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTimes(schedule: timesRespone.schedule[index],)));
                  },
                  child: Text(
                    allTranslations.text("edit"),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timesRespone.schedule[index].dayName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  timesRespone.schedule[index].dayDate,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "${allTranslations.text("from")}  : ${timesRespone.schedule[index].workFrom} ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "${allTranslations.text("to")}  : ${timesRespone.schedule[index].workTo} ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 7,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  void deleteImage(int id, index) async {
    showLoadingDialog(context);
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);

    FormData formData = FormData.fromMap(
        {"lang": allTranslations.currentLanguage, "schedule_id": id});
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("beautician/work-schedule/destroy",
        body: formData, headers: headers);
    print(response.statusCode);
    if (response.data["status"] != false) {
      Navigator.pop(context);
      onDoneDialog(
          context: context,
          text: response.data["msg"],
          function: () {
            Navigator.pop(context);
            setState(() {
              timesRespone.schedule.removeAt(index);
            });

          });
    } else {
      print("ERROR");
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print(response.data.toString());
    }
  }
}

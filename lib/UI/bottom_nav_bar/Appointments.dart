import 'dart:convert';

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomButton.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/on_done_dialog.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/beautician_schedule.dart';
import 'package:butyprovider/models/dayes_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../NetWorkUtil.dart';
import 'main_page.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  List<Days> days = [];
  List<String> timeList = List();

  BeauticianScheduleResponse timesRespone = BeauticianScheduleResponse();
  String name, datee, from, to;

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
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  @override
  void initState() {
    for (int i = 0; i < 24; i++) {
      setState(() {
        timeList.add(" 00 : ${i} ");
      });
      // print(timeList);
    }
    _calendarController = CalendarController();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400));

    days = [
      Days(
          id: 1,
          name: allTranslations.currentLanguage == "ar" ? "السبت" : "Saturday",
          isSellected: false),
      Days(
          id: 2,
          name: allTranslations.currentLanguage == "ar" ? "الاحد" : "Sunday",
          isSellected: false),
      Days(
          id: 3,
          name: allTranslations.currentLanguage == "ar" ? "الاثنين" : "Monday",
          isSellected: false),
      Days(
          id: 4,
          name:
              allTranslations.currentLanguage == "ar" ? "الثلاثاء" : "Tuesday",
          isSellected: false),
      Days(
          id: 5,
          name: allTranslations.currentLanguage == "ar"
              ? "الاربعاء"
              : "Wednesday",
          isSellected: false),
      Days(
          id: 6,
          name: allTranslations.currentLanguage == "ar" ? "الخميس" : "Thursday",
          isSellected: false),
      Days(
          id: 7,
          name: allTranslations.currentLanguage == "ar" ? "الجمعة" : "Friday",
          isSellected: false),
    ];

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
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
            centerTitle: true,
            title: Text(
              "${allTranslations.text("add_work_times")}",
              style: TextStyle(color: Colors.white),
            )),
        body: ListView(
          children: [
            _buildTableCalendar(),
            Container(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        for (int i = 0; i < days.length; i++) {
                          setState(() {
                            days[i].isSellected = false;
                          });
                        }
                        setState(() {
                          days[index].isSellected = true;
                          name = days[index].name;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              color: days[index].isSellected == false
                                  ? Colors.grey[200]
                                  : Colors.grey[500]),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(days[index].name),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "${allTranslations.text("from")}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          CustomSheet(
                              context: context,
                              widget: ListView.builder(
                                  itemCount: timeList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          from = timeList[index];
                                        });
                                        print(from);
                                        Navigator.pop(context);
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            timeList[index],
                                            textDirection: allTranslations
                                                        .currentLanguage ==
                                                    "ar"
                                                ? TextDirection.rtl
                                                : TextDirection.ltr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    );
                                  }));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(from ?? "  00 : 12  ")),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          "${allTranslations.text("to")}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          CustomSheet(
                              context: context,
                              widget: ListView.builder(
                                  itemCount: timeList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          to = timeList[index];
                                        });
                                        print(to);
                                        Navigator.pop(context);
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            timeList[index],
                                            textDirection: allTranslations
                                                        .currentLanguage ==
                                                    "ar"
                                                ? TextDirection.rtl
                                                : TextDirection.ltr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    );
                                  }));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              to ?? "  00 :12 ",
                              textAlign: TextAlign.start,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomButton(
              onBtnPress: () {
                print(datee);
                print(name);
                print(from);
                print(to);

                AddDayAPI();
              },
              text: "${allTranslations.text("add")}",
            )
          ],
        ),
      ),
    );
  }

  void AddDayAPI() async {
    showLoadingDialog(context);

    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    int id = await mSharedPreferenceManager.readInteger(CachingKey.USER_ID);
    FormData formData = FormData.fromMap({
      "lang": allTranslations.currentLanguage,
      "day_name": ["${name}"],
      "day_date": [datee],
      "work_from": ["${from}"],
      "work_to": ["${to}"],
      "beautician_id": id
    });

    print(formData.toString());
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("beautician/work-schedule/store",
        body: formData, headers: headers);
    print(response.statusCode);
    if (response.data["status"] != false) {
      Navigator.pop(context);
      onDoneDialog(
          context: context,
          text: "${response.data["msg"]}",
          function: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    index: 1,
                  ),
                ),
                (Route<dynamic> route) => false);
          });
    } else {
      print("ERROR");
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print(response.data.toString());
    }
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      startDay: DateTime.now(),
      calendarController: _calendarController,
      locale: allTranslations.currentLanguage,
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Color(0xFFBABDC3), fontSize: 12),
          weekdayStyle: TextStyle(color: Color(0xFFBABDC3), fontSize: 12)),
      startingDayOfWeek: StartingDayOfWeek.saturday,
      onUnavailableDaySelected: () {
        print("ssss");
      },
      calendarStyle: CalendarStyle(
          highlightToday: false,
          selectedColor: Theme.of(context).primaryColor,
          outsideDaysVisible: false,
          weekendStyle: TextStyle(color: Colors.black),
          holidayStyle: TextStyle(color: Color(0xFFBABDC3))),
      headerStyle:
          HeaderStyle(formatButtonVisible: false, centerHeaderTitle: true),
      onDaySelected: (date, events, holidays) {
        setState(() {
          datee = date.toString().substring(0, 10);
        });
        print(datee);
      },
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  '${date.day}',
                  style:
                      TextStyle(color: Colors.white).copyWith(fontSize: 16.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget timeContainer(String lable) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${lable}",
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

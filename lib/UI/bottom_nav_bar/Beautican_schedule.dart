import 'dart:convert';

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/UI/CustomWidgets/AppLoader.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomButton.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/dayes_model.dart';
import 'package:butyprovider/models/times.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../NetWorkUtil.dart';

class BeauticanTimes extends StatefulWidget {
  @override
  _BeauticanTimesState createState() => _BeauticanTimesState();
}

class _BeauticanTimesState extends State<BeauticanTimes>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  List<Days> days = [];

  // List<String> timeList = List();

  String name, datee, from, to;

  HoursModel hours = HoursModel();
  bool isloading = true;

  void getAllTimes() async {
    print("Times");
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response =
        await _util.get("beautician/work-schedule/times", headers: headers);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        hours = HoursModel.fromJson(json.decode(response.toString()));
        isloading = false;
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  void updatetime(int id, int status) async {
    showLoadingDialog(context);
    print("ID ==== > ${id} ");
    print("Avilable ==== > ${status == 0 ? "No" : "Yes"} ");
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    FormData body = FormData.fromMap({"time_id": id, "status": status});
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("beautician/work-schedule/store-times",
        headers: headers, body: body);
    print(response.statusCode);
    if (response.data["status"] == true) {
      print("Done");
      Navigator.pop(context);
      isloading = true;
      getAllTimes();
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  Widget TimesView() {
    return isloading == true
        ? AppLoader()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: hours.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 16 / 4),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // for (int i = 0; i < hours.data.length; i++) {
                      //   setState(() {
                      //     hours.data[i].available = false;
                      //   });
                      // }
                      // setState(() {
                      //   hours.data[index].available =
                      //       !hours.data[index].available;
                      // });

                      updatetime(hours.data[index].id,
                          hours.data[index].available == true ? 0 : 1);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " ${hours.data[index].time} PM",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Container(
                                  width: 70,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: hours.data[index].available == true
                                        ? 35
                                        : 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      width: 29,
                                      height: 29,
                                      decoration: BoxDecoration(
                                          color: hours.data[index].available ==
                                                  true
                                              ? Colors.green
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
  }

  @override
  void initState() {
    getAllTimes();
    _calendarController = CalendarController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 70,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
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
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                allTranslations.currentLanguage == "ar"
                    ? "الرجاء تحدبد الوقت الذي لا تعمل فيه "
                    : "Choose Time You Are Unavilable at",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            TimesView()
          ],
        ),
      ),
    );
  }

  void showdialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 20,
            child: Container(
                height: 290,
                width: 120,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    CustomButton(
                      text: "${allTranslations.text("this_day")}",
                    ),
                    CustomButton(
                      text: "${allTranslations.text("all_dayes")}",
                    ),
                  ],
                )),
          );
        });
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

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/Bolcs/deletNotificationBloc.dart';
import 'package:butyprovider/Bolcs/notificationBloc.dart';
import 'package:butyprovider/UI/CustomWidgets/AppLoader.dart';
import 'package:butyprovider/UI/CustomWidgets/EmptyItem.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/on_done_dialog.dart';
import 'package:butyprovider/helpers/appEvent.dart';
import 'package:butyprovider/helpers/appState.dart';
import 'package:butyprovider/models/NotificationResponse.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    notificationBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: allTranslations.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(

              centerTitle: true,
              title: Image.asset(
                "assets/images/header.png",
                fit: BoxFit.contain,
                width: 100,
                height: 30,
              )),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //        allTranslations.text("notifications"),
              //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       " مسح جميع الاشعارات ",
              //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              BlocListener<NotificationBloc, AppState>(
                bloc: notificationBloc,
                listener: (context, state) {},
                child: BlocBuilder(
                  bloc: notificationBloc,
                  builder: (context, state) {
                    var data = state.model as NotificationResponse;
                    return data == null
                        ? AppLoader()
                        : data.notifications == null
                            ? Center(
                                child: EmptyItem(
                                text:allTranslations.currentLanguage=="ar"?"لا توجد اشعارات" :"No Notifications  ",
                              ))
                            : AnimationLimiter(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.notifications.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: notificationItem(
                                            data.notifications[index].user.name,
                                            data.notifications[index].title,
                                            data.notifications[index].message,
                                            data.notifications[index].id),
                                      ),
                                    );
                                  },
                                ),
                              );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget notificationItem(String ButyName, String title, String body, int id) {
    return BlocListener(
      bloc: deleteNotificationBloc,
      listener: (context, state) {
        var data = state.model as GeneralResponse;
        if (state is Loading) showLoadingDialog(context);
        if (state is ErrorLoading) {
          Navigator.of(context).pop();
          errorDialog(
            context: context,
            text: data.msg,
          );
        }
        if (state is Done) {
          Navigator.of(context).pop();
          onDoneDialog(context: context, text: "تم حذف الاشعار بنجاح");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[200], shape: BoxShape.circle),
                        child: Center(
                          child: Image.asset(
                            "assets/images/hair.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "${ButyName}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    deleteNotificationBloc.UpdateId(id);
                    deleteNotificationBloc.add(Click());
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "${title}",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "${body}",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

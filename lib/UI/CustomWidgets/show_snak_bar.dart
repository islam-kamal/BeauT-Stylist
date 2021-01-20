//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:harajtopline/app_notification.dart';
//
//class NotificationMethos {
//  AppPushNotifications appPushNotifications = AppPushNotifications();
//
//
//  void showToast(String title, String body,
//      BuildContext context, Function function) {
//    FToast fToast = FToast(context);
//    Widget toast = InkWell(onTap: function,child: Container(
//      width: double.infinity,
//      height: MediaQuery.of(context).size.height / 7,
//      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(10.0),
//        color: Colors.grey[200],
//      ),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
//        children: [
//          Row(
//            children: <Widget>[
//              Icon(Icons.notifications_active, size: 20),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 10),
//                child: Text(
//                  "${title}",
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 14,
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//            ],
//          ),
//          Text("${body}",
//              overflow: TextOverflow.ellipsis,
//              maxLines: 2,
//              style: TextStyle(
//                fontSize: 14,
//                color: Colors.black,
//              )),
//        ],
//      ),
//    ),);
//
//    fToast.showToast(
//      child: toast,
//      gravity: ToastGravity.TOP,
//      toastDuration: Duration(seconds: 5),
//    );
//  }
//}
//
////}

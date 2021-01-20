import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Notifications.dart';

class NotificationMethos {
  AppPushNotifications appPushNotifications = AppPushNotifications();

  void showInSnackBar(String title, String body, GlobalKey<ScaffoldState> key,
      BuildContext context, Function function) {
    key.currentState.showSnackBar(
      new SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Theme.of(context).primaryColor,
        content: InkWell(
          onTap: function,
          child: Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/newlogo.png",
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
                Text(
                  body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: "Cairo",
                  ),
                )
              ],
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

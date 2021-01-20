import 'package:flutter/material.dart';

class UnauthenticatedUser extends StatefulWidget {
  @override
  _UnauthenticatedUserState createState() => _UnauthenticatedUserState();
}

class _UnauthenticatedUserState extends State<UnauthenticatedUser> {
  @override
  Widget build(BuildContext context) {
    return Center(child: _loadingView());
  }

  Widget _loadingView() {
    return Container(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/user.png"))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "عفواً الرجاء تسجيل الدخول لتتمكن من الاستفادة من خدمات التطبيق ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
//                  Navigator.pushAndRemoveUntil(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => Login(),
//                      ),
//                      (Route<dynamic> route) => false);
                },
                child: Text(
                  "عودة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: "Cairo",
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

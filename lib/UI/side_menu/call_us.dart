import 'package:butyprovider/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:butyprovider/Base/AllTranslation.dart';
class CallUs extends StatefulWidget {
  @override
  _CallUsState createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  @override
  Widget build(BuildContext context) {
    return Directionality(

      textDirection:allTranslations.currentLanguage == "ar" ? TextDirection.rtl :TextDirection.ltr,
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
              allTranslations.text("call_us"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: Column(
          children: [
            call_row(
              "Phone",
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  "assets/images/call_phone.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            call_row(
              "WhatsApp",
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  "assets/images/whats.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            call_row(
              "Twitter",
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  "assets/images/twii.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            call_row(
              "E-Mail",
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.mail,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget call_row(String social, Widget image) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          image,
          Text(
            "Contact  Us On ${social}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/UI/Auth/spash.dart';
import 'package:butyprovider/UI/side_menu/call_us.dart';
import 'package:butyprovider/UI/side_menu/change_lang.dart';
import 'package:butyprovider/UI/side_menu/edit_profile.dart';
import 'package:butyprovider/UI/side_menu/images.dart';
import 'package:butyprovider/UI/side_menu/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  final String rate;
  final String name;
  final String image;

  const MyDrawer({Key key, this.rate, this.name, this.image}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
              ),
              itemRow("${allTranslations.text("edit_profile")}",
                  Icons.person_outline, EditProfile()),
              itemRow(
                  "${allTranslations.text("images")}", Icons.image, Images()),
              itemRow("${allTranslations.text("services")}", Icons.content_cut,
                  MyService()),
              itemRow("${allTranslations.text("change_language")}",
                  Icons.language, ChangeLanguage()),
              itemRow(
                  "${allTranslations.text("call_us")}", Icons.call, CallUs()),
              itemRow("${allTranslations.text("log_out")}", Icons.arrow_back,
                  Splash())
            ],
          )),
    );
  }

  Widget itemRow(String lable, IconData icon, Widget page) {
    return InkWell(
      onTap: () async {
        if (lable == allTranslations.text("log_out")) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
            SizedBox(width: 20),
            Text(
              lable,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

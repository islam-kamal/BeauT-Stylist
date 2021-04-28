import 'package:butyprovider/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:url_launcher/url_launcher.dart';
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
              "Instagram",
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
      child: InkWell(
        onTap: (){
          switch (social) {
            case 'E-Mail':
              setState(() {
                _launchURL(
                    'mailto: Info@beautsa.com');
              });
              break;
            case 'WhatsApp':
              _launchURL(
                  'https://api.whatsapp.com/send?phone=+966 53 020 9074');
              break;
            case 'Instagram':
              _launchURL('https://instagram.com/beaut_ksa?igshid=ut2jzgyerofo');
              break;
            case 'Phone':
              _launchURL(
                  'tel:053 020 9074');
              break;
          }
        },
        child: Row(
          children: [
            image,
            Text(
              "Contact  Us On ${social}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/UI/bottom_nav_bar/reservations/reservation_view.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  String type = "current";

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
              title: Image.asset(
                "assets/images/header.png",
                fit: BoxFit.contain,
                width: 100,
                height: 30,
              )),
          body: ListView(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        type = "current";
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            allTranslations.text("current"),
                            style: TextStyle(
                                fontWeight: type == "current"
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 2,
                            color: type == "current"
                                ? Colors.black
                                : Colors.grey[200],
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      color: Colors.grey[200],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        type = "last";
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            allTranslations.text("last"),
                            style: TextStyle(
                                fontWeight: type == "last"
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 2,
                            color: type == "last"
                                ? Colors.black
                                : Colors.grey[200],
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
              type == "current"
                  ? CurrentReservationView()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 150),
                      child: Center(child: Text("No Reservations")),
                    ),
            ],
          )),
    );
  }
}

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
              centerTitle: true,
              title: Image.asset(
                "assets/images/header.png",
                fit: BoxFit.contain,
                width: 100,
                height: 30,
              )),
          body: ListView(
            children: [
              CurrentReservationView()
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width, hight;

  const AppLogo({Key key, this.width, this.hight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.contain)),
      ),
    );
  }
}

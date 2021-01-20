import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 80,
          width: 80,
          child: SpinKitChasingDots(
            color: Theme.of(context).primaryColor,
          )),
    );
  }
}

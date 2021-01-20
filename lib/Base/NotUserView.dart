import 'package:flutter/material.dart';

class NotUserView extends StatefulWidget {
  @override
  _NotUserViewState createState() => _NotUserViewState();
}

class _NotUserViewState extends State<NotUserView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(),
      ),
    );
  }
}

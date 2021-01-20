import 'package:flutter/material.dart';

class EmptyItem extends StatefulWidget {
  final String text;

  const EmptyItem({Key key, this.text}) : super(key: key);

  @override
  _EmptyItemState createState() => _EmptyItemState();
}

class _EmptyItemState extends State<EmptyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Image(
                width: MediaQuery.of(context).size.width / 1.5,
                image: ExactAssetImage("assets/images/empty.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.text ?? "لا توجد بيانات",
                style: TextStyle(fontSize: 18.0, color: Color(0xff999999)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:butyprovider/Base/AllTranslation.dart';
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height/3,
                image: ExactAssetImage("assets/images/empty.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.text ?? "${allTranslations.text("no_data")}",
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

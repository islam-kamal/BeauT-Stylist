import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final String item1;
  final String item2;

  const CustomDropdownMenu({Key key, this.item1, this.item2}) : super(key: key);

  @override
  _CustomDropdownMenuState createState() {
    return _CustomDropdownMenuState();
  }
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String _value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: DropdownButton<String>(
          iconSize: 30,
          items: [
            DropdownMenuItem<String>(
              child: Text(widget.item1),
              value: 'one',
            ),
            DropdownMenuItem<String>(
              child: Text(widget.item2),
              value: 'two',
            ),
          ],
          onChanged: (String value) {
            setState(() {
              _value = value;
            });
          },
          value: _value,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width, higth, opacity, raduis;
  final String text;
  final Color color, textColor, borderColor;
  final Function onBtnPress;

  const CustomButton(
      {Key key,
      this.width,
      this.higth,
      this.text,
      this.opacity,
      this.raduis,
      this.color,
      this.textColor,
      this.onBtnPress,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBtnPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: raduis ?? 0,
                  color: borderColor ?? Theme.of(context).primaryColor),
              color: color ?? Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5)),
          width: width ?? double.infinity,
          height: higth ?? 45,
          child: Center(
            child: Text(
              text ?? "",
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

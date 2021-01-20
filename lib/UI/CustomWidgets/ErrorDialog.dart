import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog({BuildContext context, String text, Function function}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 20,
          child: Container(
            height: function != null ? 290 : 230,
            width: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 15),
                    ),
                  ),
                  function != null
                      ? InkWell(
                          onTap: function,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "حسنا",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 12),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        );
      });
}

import 'package:BeauT_Stylist/Bolcs/forget_password_bloc.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/CustomButton.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/ErrorDialog.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/LoadingDialog.dart';
import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/models/general_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BeauT_Stylist/Base/AllTranslation.dart';
import 'check_code.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:allTranslations.currentLanguage == "ar" ? TextDirection.rtl :TextDirection.ltr,
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
        body: BlocListener(
          bloc: forgetPasswordBloc,
          listener: (context, state) {
            var data = state.model as GeneralResponse;
            if (state is Loading) showLoadingDialog(context);
            if (state is ErrorLoading) {
              Navigator.of(context).pop();
              errorDialog(
                context: context,
                text: data.msg,
              );
            }
            if (state is Done) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CheckCode()));
            }
          },
          child: Form(
            key: key,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Icon(
                      Icons.lock,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Center(child: Text(allTranslations.text("forget_password"))),
                rowItem(Icons.mail, allTranslations.text("email")),
                CustomTextField(
                  hint: "example@gmail.com",
                  validate: (String val) {
                    if (val.isEmpty) {
                      return " البريد الالكتروني غير صحيح";
                    }
                  },
                  value: (String val) {
                    forgetPasswordBloc.updateEmail(val);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onBtnPress: () {
                    if (!key.currentState.validate()) {
                      return "Invalid Email";
                    } else {
                      forgetPasswordBloc.add(Click());
                    }
                  },
                  text: allTranslations.text("send"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}

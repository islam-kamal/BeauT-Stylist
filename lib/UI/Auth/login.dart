import 'package:BeauT_Stylist/Base/AllTranslation.dart';
import 'package:BeauT_Stylist/Bolcs/loginBloc.dart';
import 'package:BeauT_Stylist/UI/Auth/forget_password.dart';
import 'package:BeauT_Stylist/UI/Auth/sign_up.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/CustomButton.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/ErrorDialog.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/LoadingDialog.dart';
import 'package:BeauT_Stylist/UI/bottom_nav_bar/main_page.dart';
import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                width: 150,
                height: 30,
              )),
          body: BlocListener(
              bloc: logInBloc,
              listener: (context, state) {
                var data = state.model as UserResponse;
                if (state is Loading) showLoadingDialog(context);
                if (state is ErrorLoading) {
                  Navigator.of(context).pop();
                  errorDialog(
                    context: context,
                    text: data.msg,
                  );
                }
                if (state is Done) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                      (Route<dynamic> route) => false);
                }
              },
              child: Form(
                key: key,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: [
                    rowItem(Icons.mail, allTranslations.text("email")),
                    CustomTextField(
                      hint: "example@gmail.com",
                      validate: (String val) {
                        if (val.isEmpty) {
                          return " البريد الالكتروني غير صحيح";
                        }
                      },
                      value: (String val) {
                        logInBloc.updateEmail(val);
                      },
                    ),
                    rowItem(Icons.lock, allTranslations.text("password")),
                    CustomTextField(
                      secureText: true,
                      validate: (String val) {
                        if (val.length < 8) {
                          return "الرقم السري غير صحيح";
                        }
                      },
                      value: (String val) {
                        logInBloc.updatePassword(val);
                      },
                      hint: "************",
                    ),
                    CustomButton(
                      onBtnPress: () {
                        if (!key.currentState.validate()) {
                          return;
                        } else {
                          logInBloc.add(Click());
                        }
                      },
                      text: allTranslations.text("login"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Center(
                            child: Text(allTranslations.text("forget_password"))),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child:
                            Center(child: Text(allTranslations.text("no_acc")))),
                  ],
                ),
              ))),
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
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

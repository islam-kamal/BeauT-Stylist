import 'package:butyprovider/Bolcs/signupBloc.dart';
import 'package:butyprovider/UI/Auth/login.dart';
import 'package:butyprovider/UI/Auth/pic_location.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomButton.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/helpers/appState.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butyprovider/Base/AllTranslation.dart';
import 'active_account.dart';
import 'complete_signUp.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showVisa = false;
  GlobalKey<FormState> key = GlobalKey();
  double lat, lng;
  var result = [];

  String address;

  Future goToLocationScreen() async {
    result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseLocation()));
    setState(() {
      address = result[0];
      lat = result[1];
      lng = result[2];
    });
  }

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
          body: BlocListener<SignUpBloc, AppState>(
            bloc: signUpBloc,
            listener: (context, state) {
              var data = state.model as GeneralResponse;
              if (state is Loading) {
                showLoadingDialog(context);
              }
              if (state is ErrorLoading) {
                Navigator.of(context).pop();
                errorDialog(
                  context: context,
                  text: data.msg,
                );
                print("Dialoggg");
              }
              if (state is Done) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActiveAccount(),
                    ),
                    (Route<dynamic> route) => false);
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    rowItem(Icons.mail, allTranslations.text("email")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.isEmpty || val.contains("@") == false) {
                          return "${allTranslations.text("email_validator")}";
                        }
                      },
                      hint: "example@gmail.com",
                      inputType: TextInputType.emailAddress,
                      value: (String val) {
                        signUpBloc.updateEmail(val);
                      },
                    ),
                    rowItem(Icons.phone, allTranslations.text("phone")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.length < 9) {
                          return "${allTranslations.text("phone_validator")}";
                        }
                      },
                      hint: "+966210025500",
                      inputType: TextInputType.phone,
                      value: (String val) {
                        signUpBloc.updateMobile(val);
                      },
                    ),
                    rowItem(Icons.location_on, allTranslations.text("address")),
                    CustomTextField(
                      initialText: address ?? "",
                      onTab: () => goToLocationScreen(),
                      validate: (String val) {
                        if (address == null) {
                          return "${allTranslations.text("address_validator")}";
                        }
                      },
                      hint: address ?? allTranslations.text("address"),
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Text(
                          allTranslations.text("pic_location"),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      ),
                      secureText: false,
                      value: (String val) {
                        signUpBloc.updatePassword(val);
                      },
                    ),
                    rowItem(Icons.lock, allTranslations.text("password")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.isEmpty) {
                          return "${allTranslations.text("password_validator")}";
                        }
                      },
                      hint: "************",
                      secureText: true,
                      value: (String val) {
                        signUpBloc.updatePassword(val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (!key.currentState.validate()) {
                          return;
                        } else {

                          signUpBloc.updateLat(lat);
                          signUpBloc.updateLng(lng);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompleteSignUp()));
                        }
                      },
                      child: CustomButton(
                        text: allTranslations.text("register"),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Center(
                            child: Text(allTranslations.text("have_acc")))),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // Widget Visa() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(allTranslations.text("card_number") ,
  //     style: TextStyle(fontSize: 13 , fontWeight: FontWeight.bold),),
  //         CustomTextField(
  //           hint: allTranslations.text("card_number"),
  //           inputType: TextInputType.number,
  //           value: (String val) {
  //             signUpBloc.updateNumber(val);
  //           },
  //         ),
  //         Text(allTranslations.text("expireDate"),
  //           style: TextStyle(fontSize: 13 , fontWeight: FontWeight.bold),),
  //         CustomTextField(
  //           hint: allTranslations.text("expireDate"),
  //           inputType: TextInputType.number,
  //           value: (String val) {
  //             signUpBloc.updateExpDate(val);
  //           },
  //         ),
  //         Text(allTranslations.text("card_holder"),
  //           style: TextStyle(fontSize: 13 , fontWeight: FontWeight.bold),),
  //         CustomTextField(
  //           hint: allTranslations.text("card_holder"),
  //           value: (String val) {
  //             signUpBloc.updateHolderName(val);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget rowItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 2,
          ),
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

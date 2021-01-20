import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/Bolcs/active_account_bloc.dart';
import 'package:butyprovider/UI/Auth/login.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/on_done_dialog.dart';
import 'package:butyprovider/helpers/appEvent.dart';
import 'package:butyprovider/helpers/appState.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ActiveAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActiveAccountState();
}

class ActiveAccountState extends State<ActiveAccount> {
  TextEditingController code;
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  bool valid_code = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: allTranslations.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
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
          bloc: activeAccount,
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
              onDoneDialog(
                  context: context,
                  text: data.msg,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  });
            }
          },
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 70),
                child: Center(
                    child: Text(
                  allTranslations.text("enter_code"),
                  textAlign: TextAlign.center,
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                ),
                child: Container(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: PinCodeTextField(
                        pinBoxWidth: 60,
                        pinBoxHeight: 60,
                        pinBoxColor: Colors.white,
                        onDone: (String value) {
                          activeAccount.updateEmail(value);
                          print(value);
                          activeAccount.add(Click());
                        },
                        defaultBorderColor: Theme.of(context).primaryColor,
                        pinBoxRadius: 5,
                        highlightPinBoxColor: Colors.grey[50],
                        hasTextBorderColor: Theme.of(context).primaryColor,
                        controller: code,
                        pinTextStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18),
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.phone,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

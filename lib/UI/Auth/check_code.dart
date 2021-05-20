import 'package:BeauT_Stylist/Base/AllTranslation.dart';
import 'package:BeauT_Stylist/Bolcs/check_code_bloc.dart';
import 'package:BeauT_Stylist/UI/Auth/reset_passeord.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/ErrorDialog.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/LoadingDialog.dart';
import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class CheckCode extends StatefulWidget {
  final String email;

  const CheckCode({Key key, this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CheckCodeState();
}

class CheckCodeState extends State<CheckCode> {
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
          bloc: checkCodeBloc,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResetPassword()));
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
                          checkCodeBloc.updateEmail(value);
                          print(value);
                          checkCodeBloc.add(Click());
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

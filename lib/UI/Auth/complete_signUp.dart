import 'dart:io';

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/Bolcs/getpayment%20methods%20bloc.dart';
import 'package:butyprovider/Bolcs/signupBloc.dart';
import 'package:butyprovider/UI/Auth/check_code.dart';
import 'package:butyprovider/UI/CustomWidgets/AppLoader.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomButton.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/helpers/appEvent.dart';
import 'package:butyprovider/helpers/appState.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:butyprovider/models/provider_payment_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CompleteSignUp extends StatefulWidget {
  @override
  _CompleteSignUpState createState() => _CompleteSignUpState();
}

class _CompleteSignUpState extends State<CompleteSignUp> {
  File _image;
  final picker = ImagePicker();
  List<File> photos = [];
  List<int> paymentMethdos = [];
  GlobalKey<FormState> key = GlobalKey();

  List<PaymentMethods> list = [
    PaymentMethods(
        isSellected: false, id: 1, name: allTranslations.text("at_buty")),
    PaymentMethods(
        isSellected: false, id: 1, name: allTranslations.text("at_home"))
  ];
  List<File> images = [];

  Widget drowGallaryBox() {
    return ListView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 100,
              height: MediaQuery.of(context).size.height / 7.5,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: FileImage(images[index]),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken))),
            ),
          );
        });
  }

  Future addImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedFile == null ? null : images.add(File(pickedFile.path));
    });
  }

  @override
  void initState() {
    allPaymentMethods.add(Hydrate());
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: allTranslations.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
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
          bloc: signUpBloc,
          listener: (context, state) {
            var data = state.model as GeneralResponse;
            if (state is ErrorLoading) {
              Navigator.of(context).pop();
              errorDialog(
                context: context,
                text: data.msg,
              );
            }
            if (state is Done) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckCode(
                      email: "karimmtahaa96@gmail.com",
                    ),
                  ));
            }
          },
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: getImage,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Container(
                          child: Center(
                            child: _image == null
                                ? Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : SizedBox(),
                          ),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _image != null
                                      ? FileImage(_image)
                                      : NetworkImage(
                                          "")),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ),
                  ),
                  rowItem(Icons.person, allTranslations.text("account_name")),
                  CustomTextField(
                    validate: (String val) {
                      if (val.isEmpty || val.contains("@") == false ) {
                        return "This Filed Must Contains ${"@"}  And Must Be In English ";
                      }
                    },
                    hint:"@username",
                    inputType: TextInputType.emailAddress,
                    value: (String val) {
                      signUpBloc.updateButeName(val);

                    },
                  ),
                  rowItem(Icons.person, allTranslations.text("name")),
                  CustomTextField(
                    validate: (String val) {
                      if (val.isEmpty) {
                        return "${allTranslations.text("complete_data")}";
                      }
                    },
                    hint: allTranslations.text("name"),
                    inputType: TextInputType.emailAddress,
                    value: (String val) {
                      signUpBloc.updateName(val);

                    },
                  ),
                  rowItem(Icons.perm_media, allTranslations.text("insta_link")),
                  CustomTextField(
                    validate: (String val) {
                      if (val.isEmpty) {
                        return "${allTranslations.text("insta_link_validator")}";
                      }
                    },
                    hint: allTranslations.text("insta_link"),
                    inputType: TextInputType.emailAddress,
                    value: (String val) {
                      signUpBloc.updateInstalink(val);
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Text(
                      allTranslations.text("payment_methods"),
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  paymentmethods(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Text(
                      allTranslations.text("service_address"),
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  service_address(),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Text(
                      allTranslations.text("last_works"),
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 7.3,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          InkWell(
                            onTap: addImage,
                            child: Container(
                              width: 100,
                              height: MediaQuery.of(context).size.height / 7.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: Center(
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                          drowGallaryBox(),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onBtnPress: () {
                      if (!key.currentState.validate()) {
                        return;
                      }else{
                        signUpBloc.updateImages(images);
                        signUpBloc.updatepayment(paymentMethdos);
                        signUpBloc.updateimagee(_image);
                        signUpBloc.add(Click());

                      }

                    },
                    text: "${allTranslations.text("register")}",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  Widget paymentmethods() {
    return BlocListener(
      bloc: allPaymentMethods,
      listener: (context, state) {},
      child: BlocBuilder(
          bloc: allPaymentMethods,
          builder: (context, state) {
            var data = state.model as ProviderPaymentMethodResponse;
            return Container(
              height: 50,
              child: data == null
                  ? AppLoader()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.paymentMethods.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (data.paymentMethods[index].isSellected ==
                                false) {
                              setState(() {
                                data.paymentMethods[index].isSellected = true;
                                paymentMethdos
                                    .add(data.paymentMethods[index].id);
                              });
                            } else {
                              setState(() {
                                data.paymentMethods[index].isSellected = false;
                              });
                              for (int i = 0;
                                  i <= data.paymentMethods.length;
                                  i++) {
                                if (data.paymentMethods[i].isSellected ==
                                    false) {
                                  paymentMethdos.removeAt(i);
                                  print(paymentMethdos.toString());
                                }
                              }
                            }
                            print(paymentMethdos);
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(data.paymentMethods[index].name),
                              ),
                              data.paymentMethods[index].isSellected == false
                                  ? Icon(
                                      Icons.check_box_outline_blank,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : Icon(
                                      Icons.check_box,
                                      color: Theme.of(context).primaryColor,
                                    )
                            ],
                          ),
                        );
                      }),
            );
          }),
    );
  }

  Widget service_address() {
    return Container(
      width: double.infinity,
      height: 60,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  list[index].isSellected = !list[index].isSellected;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    list[index].isSellected == false
                        ? Icon(
                            Icons.check_box_outline_blank,
                            color: Theme.of(context).primaryColor,
                          )
                        : Icon(
                            Icons.check_box,
                            color: Theme.of(context).primaryColor,
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(list[index].name),
                    ),
                    index == 0
                        ? Container(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.directions_car,
                                  color: Theme.of(context).primaryColor,
                                )),
                            decoration: BoxDecoration(
                                color: Colors.grey[50], shape: BoxShape.circle),
                          )
                        : Container(
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.home,
                                  color: Theme.of(context).primaryColor,
                                )),
                            decoration: BoxDecoration(
                                color: Colors.grey[50], shape: BoxShape.circle),
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

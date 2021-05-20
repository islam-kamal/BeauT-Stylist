import 'dart:convert';
import 'dart:io';

import 'package:BeauT_Stylist/Base/AllTranslation.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/CustomButton.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/ErrorDialog.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/LoadingDialog.dart';
import 'package:BeauT_Stylist/UI/CustomWidgets/on_done_dialog.dart';
import 'package:BeauT_Stylist/UI/bottom_nav_bar/main_page.dart';
import 'package:BeauT_Stylist/helpers/shared_preference_manger.dart';
import 'package:BeauT_Stylist/models/categories_response.dart';
import 'package:BeauT_Stylist/models/services_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../NetWorkUtil.dart';

class EditService extends StatefulWidget {


  final Services services ;

  const EditService({Key key, this.services}) : super(key: key);
  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  String name_ar, name_en, desc_ar, desc_en, price, time, cat_name;
  File imagee;
  int location_id, cat_id, location;
  bool at_home = true;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imagee = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  CategoriesResponse ress = CategoriesResponse();

  void getCats() async {
    print("getting Cats");
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
    await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.get("beautician/categories/get-categories",
        headers: headers);
    print(response.statusCode);
    if (response.data != null) {
      print("Done");
      setState(() {
        ress = CategoriesResponse.fromJson(json.decode(response.toString()));
      });
    } else {
      print("ERROR");
      print(response.data.toString());
    }
  }

  @override
  void initState() {
    getCats();
    super.initState();
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
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            centerTitle: true,
            title: Text(
              allTranslations.text("add_services"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: SingleChildScrollView(
            child: Column(
              children: [
                categoriesWidgets(),
                CustomTextField(
                  label:widget.services.nameAr?? "${allTranslations.text("service_name")} (Ar)",
                  value: (String val) {
                    setState(() {
                      name_ar = val;
                    });
                  },
                ),
                CustomTextField(
                  label:widget.services.nameEn?? "${allTranslations.text("service_name")} (En)",
                  value: (String val) {
                    setState(() {
                      name_en = val;
                    });
                  },
                ),
                CustomTextField(
                  lines: 3,
                  label:widget.services.detailsAr?? "${allTranslations.text("details")} (Ar)",
                  value: (String val) {
                    setState(() {
                      desc_ar = val;
                    });
                  },
                ),
                CustomTextField(
                  lines: 3,
                  label:widget.services.detailsEn?? "${allTranslations.text("details")} (En)",
                  value: (String val) {
                    setState(() {
                      desc_en = val;
                    });
                  },
                ),
                SellectImage(),
                CustomTextField(
                  label:widget.services.price?? "${allTranslations.text("price")}",
                  value: (String val) {
                    setState(() {
                      price = val;
                    });
                  },
                ),
                CustomTextField(
                  label: widget.services.estimatedTime?? "${allTranslations.text("service_time")}",
                  value: (String val) {
                    setState(() {
                      time = val;
                    });
                  },
                ),
                service_address(),
                CustomButton(
                  onBtnPress: () {
                    addService();
                  },
                  text: "${allTranslations.text("edit")}",
                )
              ],
            )),
      ),
    );
  }

  Widget SellectImage() {
    return InkWell(
        onTap: getImage,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(imagee == null
                      ? " ${allTranslations.text("service_image")} "
                      : "${allTranslations.text("done_image")}"),
                  imagee == null
                      ? Icon(Icons.image)
                      : Icon(
                    Icons.done_outline,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5)),
          ),
        ));
  }

  Widget categoriesWidgets() {
    return InkWell(
      onTap: () {
        CustomSheet(
            context: context,
            widget: ListView.builder(
                itemCount: ress.categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            cat_name = ress.categories[index].name;
                            cat_id = ress.categories[index].id;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          ress.categories[index].name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider()
                    ],
                  );
                }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cat_name ?? " ${allTranslations.text("choose_cat")}"),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  Widget service_address() {
    return Container(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  at_home = false;
                  location = 1;
                });
              },
              child: Row(
                children: [
                  at_home == true
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
                    child: Text(allTranslations.text("at_buty")),
                  ),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.directions_car,
                          color: Theme.of(context).primaryColor,
                        )),
                    decoration: BoxDecoration(
                        color: Colors.grey[50], shape: BoxShape.circle),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  at_home = true;
                  location = 0;
                });
              },
              child: Row(
                children: [
                  at_home == true
                      ? Icon(
                    Icons.check_box,
                    color: Theme.of(context).primaryColor,
                  )
                      : Icon(
                    Icons.check_box_outline_blank,
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(allTranslations.text("at_home")),
                  ),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.home,
                          color: Theme.of(context).primaryColor,
                        )),
                    decoration: BoxDecoration(
                        color: Colors.grey[50], shape: BoxShape.circle),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addService() async {
    showLoadingDialog(context);
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
    await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    int id = await mSharedPreferenceManager.readInteger(CachingKey.USER_ID);
    print("IDDDDDD  =====> ${id}");
    FormData formData = FormData.fromMap({
      "lang": allTranslations.currentLanguage,
      "name_ar": name_ar,
      "name_en": name_en,
      "details_en": desc_ar,
      "details_ar": desc_en,
      "category_id": cat_id,
      "price": price,
      "estimated_time": time,
      "location": at_home == true ? 0 : 1,
      "service_icon":imagee ==null ? null : await MultipartFile.fromFile(imagee.path),
      "beautician_id": id,
      "service_id": widget.services.id
    });
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("beautician/services/update",
        body: formData, headers: headers);
    print(response.statusCode);
    if (response.data["status"] != false) {
      Navigator.pop(context);

      onDoneDialog(
          context: context,
          text: response.data["msg"],
          function: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    index: 2,
                  ),
                ),
                    (Route<dynamic> route) => false);
          });
    } else {
      print("ERROR");
      Navigator.pop(context);
      errorDialog(
          context: context,
          text: response.data["msg"],
          function: () {
            Navigator.pop(context);
          });
      print(response.data.toString());
    }
  }
}

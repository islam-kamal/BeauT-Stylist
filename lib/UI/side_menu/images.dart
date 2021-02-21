import 'dart:io';

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/Bolcs/get_images_bloc.dart';
import 'package:butyprovider/UI/CustomWidgets/AppLoader.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:butyprovider/UI/CustomWidgets/CustomButton.dart';
import 'package:butyprovider/UI/CustomWidgets/ErrorDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/LoadingDialog.dart';
import 'package:butyprovider/UI/CustomWidgets/on_done_dialog.dart';
import 'package:butyprovider/UI/bottom_nav_bar/main_page.dart';
import 'package:butyprovider/helpers/appEvent.dart';
import 'package:butyprovider/helpers/appState.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/all_images_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';

import '../../NetWorkUtil.dart';

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  List<File> images = [];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery , imageQuality: 50 , maxHeight: 300 , maxWidth: 300);
    setState(() {
      pickedFile == null ? null : images.add(File(pickedFile.path));
    });
    pickedFile == null ? null : addSalonImages();
  }

  void addSalonImages() async {
    List<MultipartFile> _photos = [];
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    showLoadingDialog(context);

    FormData formData =
        FormData.fromMap({"lang": allTranslations.currentLanguage});
    Map<String, String> headers = {
      'Authorization': token,
    };
    for (int i = 0; i < images.length; i++) {
      _photos.add(MultipartFile.fromFileSync(images[i].path,
          filename: "${images[i].path}.jpg"));
      formData.files.add(MapEntry("photos[${i}]", _photos[i]));
    }

    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("beautician/gallery/store",
        body: formData, headers: headers);
    print(response.statusCode);
    if (response.data["status"] != false) {
      print("Done");
      Navigator.pop(context);
      onDoneDialog(
          context: context,
          text: "${response.data["msg"]}",
          function: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Images()));
          });
    } else {
      print("ERROR");
      print(response.data.toString());
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
    }
  }

  void deleteImage(int id, Function onDone) async {
    showLoadingDialog(context);
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);

    FormData formData = FormData.fromMap(
        {"lang": allTranslations.currentLanguage, "gallery_id": id});
    Map<String, String> headers = {
      'Authorization': token,
    };
    NetworkUtil _util = NetworkUtil();
    Response response = await _util.post("beautician/gallery/destroy",
        body: formData, headers: headers);
    print(response.statusCode);
    if (response.data["status"] != false) {
      onDone();
    } else {
      print("ERROR");
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print(response.data.toString());
    }
  }

  @override
  void initState() {
    getImagesBloc.add(Hydrate());
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                                index: 0,
                              )));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            centerTitle: true,
            title: Text(
              allTranslations.text("images"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: ListView(
          children: [
            InkWell(
              onTap: getImage,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${allTranslations.text("add_Image")}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            BlocListener<GetImagesBloc, AppState>(
              bloc: getImagesBloc,
              listener: (context, state) {},
              child: BlocBuilder(
                bloc: getImagesBloc,
                builder: (context, state) {
                  var data = state.model as GallaryResponse;
                  return data == null
                      ? AppLoader()
                      : AnimationLimiter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.gallery.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: Stack(
                                  children: [
                                    Card(
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(data
                                                    .gallery[index].photo))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        CustomSheet(
                                            context: context,
                                            hight: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            widget: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: Text(
                                                    "هل انت متأكد من حذف الصورة",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomButton(
                                                      onBtnPress: () {
                                                        Navigator.pop(context);
                                                        print(
                                                            "Deleting Image ======> ${data.gallery[index].id}");
                                                        deleteImage(
                                                            data.gallery[index]
                                                                .id, () {
                                                          print("Done");
                                                          Navigator.pop(
                                                              context);
                                                          onDoneDialog(
                                                              context: context,
                                                              text:
                                                                  "تم الحذف بنجاح",
                                                              function: () {
                                                                setState(() {
                                                                  data.gallery
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                        });
                                                      },
                                                      text: "نعم ",
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.7,
                                                    ),
                                                    CustomButton(
                                                      onBtnPress: () {
                                                        Navigator.pop(context);
                                                      },
                                                      text: "لا",
                                                      color: Colors.white,
                                                      borderColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      textColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.7,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 130, right: 20, left: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(),
                                            Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Container(
                                                child: Center(
                                                  child: Icon(Icons.delete),
                                                ),
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

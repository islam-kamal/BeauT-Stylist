/*
import 'dart:io';
import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog {
  Widget _roundedButton({String label, Color bgColor, Color txtColor}) {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        padding: EdgeInsets.all(15.0),
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
            color: bgColor,
            borderRadius: new BorderRadius.all(const Radius.circular(100.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: const Color(0xFF696969),
                  offset: Offset(1.0, 6.0),
                  blurRadius: 0.001)
            ]),
        child: Text(label,
            style: new TextStyle(
                color: txtColor, fontSize: 20.0, fontWeight: FontWeight.bold)));
  }

  _openCamera(ValueChanged<File> onGet, BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _cropImage(image, onGet, context);
  }

  _openGallery(ValueChanged<File> onGet, BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _cropImage(image, onGet, context);
  }

  _cropImage(File image, ValueChanged<File> onGet, BuildContext context) async {
    File _croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxWidth: 512,
        maxHeight: 512,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    File _compressed = await _compress(_croppedFile);
    onGet(_compressed);
    Navigator.pop(context);
  }

  Future<File> _compress(File file) async {
    final _dir = await path_provider.getTemporaryDirectory();
    final _targetPath = _dir.absolute.path + "/temp${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, _targetPath,
        quality: 70);

    return result;
  }

  show({ValueChanged<File> onGet, BuildContext context}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Material(
              type: MaterialType.transparency,
              child: Opacity(
                  opacity: 1.0,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffd34600) ,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${allTranslations.text("add_photo")}" , style: TextStyle(color: Colors.white),),
                                )) ,
                            GestureDetector(
                                onTap: () => _openCamera(onGet, context),
                                child: _roundedButton(
                                    label: "${allTranslations.text("camera")}",
                                    bgColor: Theme.of(context).primaryColor,
                                    txtColor: Colors.white)),
                            GestureDetector(
                              onTap: () => _openGallery(onGet, context),
                              child: _roundedButton(
                                  label: "${allTranslations.text("gallery")}",
                                  bgColor:  Color(0xFFFFFFFF),
                                  txtColor:  Color.fromRGBO(31, 32, 34, 1.0)),
                            ),
                            SizedBox(height: 15.0),
                            GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: new Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        30.0, 0.0, 30.0, 0.0),
                                    child: _roundedButton(
                                        label: "${allTranslations.text("cancel")}",
                                        bgColor: Colors.black,
                                        txtColor: Colors.white)))
                          ]))));
        });
  }
}*/

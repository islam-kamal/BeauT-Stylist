import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/Base/NetworkUtil.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/all_images_model.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:dio/dio.dart';

class ImagesRepo {
  static Future<GallaryResponse> GetImages() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
      return NetworkUtil.internal().get(GallaryResponse(),
          "beautician/gallery/get-all-gallery?lang=${allTranslations.currentLanguage}",
          headers: headers);
    }

  static Future<GeneralResponse> deleteImage(int id) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    Map<String, String> headers = {
      'Authorization': token,
    };
    FormData data = FormData.fromMap(
        {"photo_id": id, "lang": allTranslations.currentLanguage});

    print("deleting image ===== > ID = ${id} From REPO Layer");
    print("deleting image ===== > Token = ${headers} From REPO Layer");

    return NetworkUtil.internal().post(
        GeneralResponse(), "beautician/gallery/destroy",
        headers: headers, body: data);
  }
}

import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:butyprovider/Base/NetworkUtil.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/all_images_model.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:butyprovider/models/services_response.dart';

class ServicesRepo {
  static Future<ServicesResponse> GetServices() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
    await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(ServicesResponse(),
        "beautician/services/get-all-services?lang=${allTranslations.currentLanguage}",
        headers: headers);
  }

  static Future<GeneralResponse> deleteImage(int id) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
    await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().post(
        GeneralResponse(), "beautician/gallery/destroy?lang=ar&gallery_id=${id}",
        headers: headers);
  }
}

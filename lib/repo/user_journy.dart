import 'package:butyprovider/Base/NetworkUtil.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/current_ordera_model.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:butyprovider/models/home_page_response.dart';
import 'package:dio/dio.dart';
import 'package:butyprovider/Base/AllTranslation.dart';
class UserJourny {
//------------------------------------------------------------------------------/
  static Future<CurrentOrdersResponse> GETCURRENTORDERS() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(CurrentOrdersResponse(),
        "beautician/orders/get-new-orders?lang=${allTranslations.currentLanguage}",
        headers: headers);
  }

//------------------------------------------------------------------------------/
  static Future<GeneralResponse> CanselOrder(int id, int status) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "order_id": id,
      "order_status": status,
    });
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().post(
        GeneralResponse(), "beautician/orders/change-status",
        headers: headers, body: data);
  }


//------------------------------------------------------------------------------/
//   static Future<HomePageResponse> GetHomePageData() async {
//
//     print("Lang ==== >${allTranslations.currentLanguage}");
//     var mSharedPreferenceManager = SharedPreferenceManager();
//     var token =
//     await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
//     print(token);
//     Map<String, String> headers = {
//       'Authorization': token,
//     };
//
//     return NetworkUtil.internal().post(HomePageResponse(),
//         "beautician//beautician-revenue?lang=${allTranslations.currentLanguage}",
//         headers: headers);
//   }

}

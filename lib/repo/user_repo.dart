import 'dart:io';

import 'package:butyprovider/Base/NetworkUtil.dart';
import 'package:butyprovider/helpers/shared_preference_manger.dart';
import 'package:butyprovider/models/NotificationResponse.dart';
import 'package:butyprovider/models/general_response.dart';
import 'package:butyprovider/models/login_model.dart';
import 'package:butyprovider/models/provider_payment_methods.dart';
import 'package:butyprovider/models/updateProfileResponse.dart';
import 'package:butyprovider/models/user_profile_response.dart';
import 'package:dio/dio.dart';
import 'package:butyprovider/Base/AllTranslation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataRepo {
  static Future<UserResponse> LOGIN(String email, String password) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    print(token);
    FormData data = FormData.fromMap({
      "email": email,
      "password": password,
      "deviceToken": preferences.getString("msgToken")
    });
    return NetworkUtil.internal().post(
      UserResponse(),
      "beautician/auth/login",
      body: data,
    );
  }

//-------------------------------------------------------------------------------

  static Future<GeneralResponse> ForgetPassword(String email) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "email": email,
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "beautician/auth/send-code",
      body: data,
    );
  }

//-------------------------------------------------------------------------------

  static Future<GeneralResponse> ResendCode(String email) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "email": email,
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "beautician/auth/send-code",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<GeneralResponse> CheckCode(String code) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    print(email);
    FormData data = FormData.fromMap(
        {"email": email, "code": code, "lang": allTranslations.currentLanguage});
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "beautician/auth/code-check",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<GeneralResponse> ActiveAccountFunction(String code) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    print(email);
    FormData data = FormData.fromMap(
        {"email": email, "code": code, "lang": allTranslations.currentLanguage});
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "beautician/auth/code-check",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<GeneralResponse> RestePassword(
      String password, String confirmPassword) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    print(email);
    FormData data = FormData.fromMap({
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "lang": allTranslations.currentLanguage
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "beautician/auth/reset-password",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<UpadteProfileResponse> UpdateProfileApi(
      String name,
      String email,
      String newPassword,
      String mobile,
      String currentPassword,
      String confirmPassword ) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };

    FormData data = FormData.fromMap({
      "update_name": name,
      "update_email": email,
      "update_mobile": mobile,
      "update_password": newPassword,
      "update_password_confirmation": confirmPassword,
      "current_password": currentPassword,
      "lang": allTranslations.currentLanguage
    });
    return NetworkUtil.internal().post(
        UpadteProfileResponse(), "beautician/user/update",
        body: data, headers: headers);
  }

//-------------------------------------------------------------------------------
  static Future<UserProfileResoonse> GetProfileApi() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal()
        .post(UserProfileResoonse(), "beautician/user/get-user", headers: headers);
  }

//-------------------------------------------------------------------------------

  static Future<GeneralResponse> SIGNUP({
   String owner_name ,
    String beaut_name ,
    String email,
    String password ,
    String mobile ,
    String address ,
    double lat ,
    double lng ,
    List<File> photos ,
    List<int> payment ,
    int city_id ,
    String insta_link ,
    File photo
  }) async {
    List<MultipartFile> _photos = [];

    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(token);
    FormData data = FormData.fromMap({
      "owner_name": owner_name,
      "email": email,
      "password": password,
      "mobile": mobile,
      "address": address,
      "longitude": lng ?? 31.245175,
      "latitude": lat ?? 41.245175,
      "payment_method": payment,
      "beaut_name": beaut_name,
      "lang": allTranslations.currentLanguage,
      "city_id": 11,
      "insta_link": insta_link,
      "photo": await MultipartFile.fromFile(photo.path),
      "deviceToken": preferences.getString("msgToken")
    });
    for (int i = 0; i < photos.length; i++) {
      _photos.add(MultipartFile.fromFileSync(photos[i].path,
          filename: "${photos[i].path}.jpg"));
      data.files.add(MapEntry("photos[${i}]", _photos[i]));
      return NetworkUtil.internal().post(
        GeneralResponse(),
        "beautician/auth/signup",
        body: data,
      );
    }
  }

//-------------------------------------------------------------------------------
  static Future<NotificationResponse> GetNotifications() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(NotificationResponse(),
        "beautician/notifications/get-beautician-notifications?lang=${allTranslations.currentLanguage}",
        headers: headers);
  }

  //-------------------------------------------------------------------------------

  static Future<GeneralResponse> ClearNotifications(int id) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    FormData data = FormData.fromMap({
      "id": id,
    });
    return NetworkUtil.internal().post(GeneralResponse(), "beautician/user/delete",
        headers: headers, body: data);
  }

  static Future<ProviderPaymentMethodResponse> getPaymentMethods() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(ProviderPaymentMethodResponse(),
        "methods/get-all-methods?lang=${allTranslations.currentLanguage}",
        headers: headers);
  }
}

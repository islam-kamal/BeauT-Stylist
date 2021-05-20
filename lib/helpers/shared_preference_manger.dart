import 'package:BeauT_Stylist/helpers/enumeration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  SharedPreferences sharedPreferences;

  Future<bool> removeData(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key.value);
  }

  Future<bool> logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  Future<bool> writeData(CachingKey key, value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(
        "saving this value $value into local prefrence with key ${key.value}");
    Future returnedValue;
    if (value is String) {
      returnedValue = sharedPreferences.setString(key.value, value);
    } else if (value is int) {
      returnedValue = sharedPreferences.setInt(key.value, value);
    } else if (value is bool) {
      returnedValue = sharedPreferences.setBool(key.value, value);
    } else if (value is double) {
      returnedValue = sharedPreferences.setDouble(key.value, value);
    } else {
      return Future.error(NotValidCacheTypeException());
    }
    return returnedValue;
  }

  Future<bool> readBoolean(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getBool(key.value) ?? false);
  }

  Future<double> readDouble(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getDouble(key.value) ?? 0.0);
  }

  Future<int> readInteger(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getInt(key.value) ?? 0);
  }

  Future<String> readString(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getString(key.value) ?? "");
  }
}

class NotValidCacheTypeException implements Exception {
  String message() => "Not a valid cahing type";
}

class CachingKey extends Enum<String> {
  const CachingKey(String val) : super(val);
  static const CachingKey USER_NAME = const CachingKey('USER_NAME');
  static const CachingKey EMAIL = const CachingKey('EMAIL');
  static const CachingKey USER_ID = const CachingKey('USER_ID');
  static const CachingKey AUTH_TOKEN = const CachingKey('AUTH_TOKEN');
  static const CachingKey USER_IMAGE = const CachingKey('USER_IMAGE');
  static const CachingKey ID_IMAGE = const CachingKey('ID_IMAGE');
  static const CachingKey IS_LOGGED_IN = const CachingKey('IS_LOGGED_IN');
  static const CachingKey USER_TYPE = const CachingKey('USER_TYPE');
  static const CachingKey REFERRAL_CODE = const CachingKey('REFERRAL_CODE');
  static const CachingKey MOBILE_NUMBER = const CachingKey('MOBILE_NUMBER');
  static const CachingKey ADDRESS = const CachingKey('ADDRESS');
  static const CachingKey RATE = const CachingKey('RATE');
}

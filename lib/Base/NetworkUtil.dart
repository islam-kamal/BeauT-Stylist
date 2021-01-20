import 'package:butyprovider/helpers/network-mappers.dart';
import 'package:dio/dio.dart';

class NetworkUtil {
  static final NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();

  String base_url = "https://beauty.wothoq.co/api/";

  Future<ResponseType> get<ResponseType extends Mappable>(
      ResponseType responseType, String url,
      {Map headers}) async {
    var response;
    try {
      dio.options.baseUrl = base_url;
      response = await dio.get(url, options: Options(headers: headers));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse(response, responseType);
  }

  Future<ResponseType> post<ResponseType extends Mappable>(
      ResponseType responseType, String url,
      {Map headers, FormData body, encoding}) async {
    var response;
    dio.options.baseUrl = base_url;
    try {
      print(headers);
      print(body.fields);
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        print("HERER");
        response = e.response;
      }
    }
    return handleResponse(response, responseType);
  }

  Future<ResponseType> put<ResponseType extends Mappable>(
      ResponseType responseType, String url,
      {Map headers, FormData body, encoding}) async {
    var response;
    dio.options.baseUrl = base_url;
    try {
      print(headers);
      print(body.fields);
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        print("HERER");
        response = e.response;
      }
    }
    return handleResponse(response, responseType);
  }

  ResponseType handleResponse<ResponseType extends Mappable>(
      Response response, ResponseType responseType) {
    final int statusCode = response.statusCode;
    print("Status Code " + statusCode.toString());

    if (statusCode >= 200 && statusCode < 300) {
      print("correrct request: " + response.toString());
      print("Status Code " + statusCode.toString());

      return Mappable(responseType, response.toString()) as ResponseType;
    } else {
      print("request error: " + response.toString());
      print("Status Code " + statusCode.toString());
      return Mappable(responseType, response.toString()) as ResponseType;
    }
  }
}

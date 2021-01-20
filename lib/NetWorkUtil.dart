import 'package:dio/dio.dart';

class NetworkUtil{

  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  String base_url = "https://beauty.wothoq.co/api/";

  Dio dio = Dio();

  factory NetworkUtil() => _instance;

  Future<Response> get(String url, {Map headers}) async {
    var response;
    try {
      dio.options.baseUrl = base_url;
      response = await dio.get(url, options: Options(headers: headers));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        handleResponse(e.response);
        print("RESS" + e.response.toString());
      } else {
        print("LAAAAAA " + e.toString());
      }
    }
    return handleResponse(response);
  }

  Future<Response> post(String url,
      {Map headers, FormData body, encoding}) async {
    var response;
    dio.options.baseUrl = base_url;
    try {
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        print("RESS" + e.response.toString());
        handleResponse(e.response);
      } else {
        print("LAAAAAA " + e.toString());
      }
      return handleResponse(e.response);
    }

    return handleResponse(response);
  }

  Future<Response> delete(String url, {Map headers}) {
    return dio
        .delete(
      url,
      options: Options(headers: headers),
    )
        .then((Response response) {
      return handleResponse(response);
    });
  }

  Future<Response> put(String url, {Map headers, body, encoding}) {
    return dio
        .put(url,
            data: body,
            options: Options(headers: headers, requestEncoder: encoding))
        .then((Response response) {
      return handleResponse(response);
    });
  }

  Response handleResponse(Response response) {
    final int statusCode = response.statusCode;
    print("RESPONSE : " + response.toString());
    if (statusCode == 401) {
      throw new Exception("Unauthorized");
    } else if (statusCode == 500) {
      print("Talkaaaaaa");
      Response data = Response(
          data: blocReponse(message: "network_error", success: "false"),
          statusCode: 500);
      return data;
    } else if (statusCode >= 200 && statusCode < 300) {
      return response;
    } else {
      return response;
    }
  }
}

class blocReponse {
  String success;
  String message;

  blocReponse({this.success, this.message});

  blocReponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_services;

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    dio.options.headers['content-type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'get'))
        .then(
      (value) {
        return value;
      },
    );
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    dio.options.headers['content-type'] = 'application/json';
    //ToDo read token From storage
    return await dio
        .post(url,
            data: dio_services.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: "POST"))
        .then(
      (value) {
        log(value.headers.toString());
        log(value.data.toString());
        log(value.statusCode.toString());
        return value;
      },
    );
  }
}

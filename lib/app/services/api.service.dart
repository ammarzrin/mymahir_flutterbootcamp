import 'dart:developer';

import 'package:dio/dio.dart';

final ApiServices api = ApiServices();

class ApiServices {
  var baseurl = 'https://dummyjson.com';

  Future getDio(String path, {Map<String, dynamic>? params}) async {
    String url = baseurl + path;
    var headers = {'accept': 'application/json'};

    try {
      var response = await Dio().get(
        url,
        queryParameters: params,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      log('API Error: ${e.toString()}');
    }
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:myflutter_nov2025/app/services/sharedprefs.dart';

final ApiServices api = ApiServices();

class ApiServices {
  // var baseurl = 'http://10.0.2.2:3000/api';
  var baseurl = 'https://myexpressnov2025-production.up.railway.app/api';
  // Email: khairi@mail.com
  // Password: P@ssw0rd

  Future<Response?> postDio(String path, FormData? formdata) async {
    String? token = await SharedPrefs.getLocalStorage('token') ?? '';
    String url = baseurl + path;
    var headers = {'accept': 'application/json'};

    if (token.isNotEmpty) {
      headers['authorization'] = 'Bearer $token';
    }
    var response = await Dio().post(
      url,
      data: formdata,
      options: Options(headers: headers),
    );
    return response;
  }

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

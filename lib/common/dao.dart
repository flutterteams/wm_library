import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wm_library/config/config.dart';

class Dao {
  static get(url, para, success, failure) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      dio.options.headers = {
        HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')
      };

      response = await dio.get(Config.BASE_URL + url, queryParameters: para);

      if (response.data['code'] == 1) {
        success(response.data);
      } else {
        if (failure != null) {
          failure(response.data);
        }
      }
    } catch (e) {
      return print(e);
    }
  }

  static post(url, para, success, failure) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      dio.options.headers = {
        HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')
      };

      response = await dio.post(Config.BASE_URL + url, data: para);

      if (response.data['code'] == 1) {
        success(response.data);
      } else {
        if (failure != null) {
          failure(response.data);
        }
      }
    } catch (e) {
      return print(e);
    }
  }

  static noTokenPost(url, para, success, failure) async {
    try {
      Response response;
      Dio dio = new Dio();

      response = await dio.post(Config.BASE_URL + url, data: para);

      if (response.data['code'] == 1) {
        success(response.data);
      } else {
        if (failure != null) {
          failure(response.data);
        }
      }
    } catch (e) {
      return print(e);
    }
  }
}

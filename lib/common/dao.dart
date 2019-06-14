import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wm_library/config/config.dart';

class Dao {

  static Dio dio;
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 5000;

  static SharedPreferences sharedPreferences;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';
  static const String DOWNLOAD = 'download';

  /// 创建 dio 实例对象
  static Dio createInstance()  {
    /// 全局属性：请求前缀、连接超时时间、响应超时时间、
    dio = new Dio();
    dio.options.baseUrl = Config.BASE_URL;
    dio.options.connectTimeout = CONNECT_TIMEOUT; //5s
    dio.options.receiveTimeout = RECEIVE_TIMEOUT;

    return dio;
  }
  static get(url, para, success, failure) async {

    try {
      Response response;
      //Dio dio = new Dio();
      dio = createInstance();
      sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {
        HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')
      };

      /// 打印请求相关信息：请求地址、请求方式、请求参数
      //print('请求地址：【'  + '  ' + url + '】');
      //print('请求参数：' + para.toString());

      response = await dio.get( url, queryParameters: para);

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
      //Dio dio = new Dio();
      dio = createInstance();
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      dio.options.headers = {
        HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')
      };

      /// 打印请求相关信息：请求地址、请求方式、请求参数
      //print('请求地址：【'  + '  ' + url + '】');
      //print('请求参数：' + para.toString());

      response = await dio.post(url, data: para);

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
      clear();
      Response response;
      Dio dio = new Dio();
      response = await dio.post(Config.BASE_URL + url, data: para);

      //print('请求地址：【'  + '  ' + Config.BASE_URL + url + '】');
      //print('请求参数：' + para.toString());

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

  /// 清空 dio 对象
  static clear () {
    dio = null;
  }

}
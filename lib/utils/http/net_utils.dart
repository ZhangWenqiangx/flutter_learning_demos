import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'app_exceptions.dart';

Map<String, dynamic> optHeader = {'content-type': 'application/json'};

var dio = Dio(BaseOptions(connectTimeout: 30000, headers: optHeader));

class NetUtils {
  static Future get(String url, [Map<String, dynamic>? params]) async {
    var response;
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return getData(response);
  }

  static Future post(String url, Map<String, dynamic> params) async {
    var response = await dio.post(url, data: params);
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return getData(response);
  }

  static Future postForm(String url, FormData params) async {
    var response = await dio.post(url, data: params);
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return getData(response);
  }

  static getData(Response response) {
    String jsonStr = json.encode(response.data);
    Map<String, dynamic> map = json.decode(jsonStr);
    return map['data'];
  }
}

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String jsonStr = json.encode(response.data);
    Map<String, dynamic> map = json.decode(jsonStr);
    var err = map['errorCode'];
    if (err == ErrCode.SUCCESS) {
      handler.next(response);
    }else if(err == ErrCode.TOKEN_ERR){
      //处理token过期
    } else {
      handler.reject(DioError(
          requestOptions: response.requestOptions,
          error: response.data != null &&
                  response.data is Map &&
                  response.data['errorMsg'] != null &&
                  response.data['errorMsg'].length > 0
              ? response.data['errorMsg']
              : "未知异常",
          response: response));
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    AppException appException = AppException.create(err);
    err.error = appException;
    return super.onError(err, handler);
  }
}

class ErrCode {
  /// 成功
  static const SUCCESS = 0;

  /// 登录失效
  static const TOKEN_ERR = -1001;
}

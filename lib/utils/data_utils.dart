import 'package:dio/dio.dart';
import 'package:flutter_demo/api/api.dart';
import 'package:flutter_demo/models/UserInfo.dart';

import 'http/api_response.dart';
import 'http/net_utils.dart';

class DataUtils {
  // 登陆获取用户信息
  static Future<ApiResponse<UserInfo>> doLogin(
      String username, String password) async {
    var response = await NetUtils.postForm(
        Api.DO_LOGIN,
        new FormData.fromMap({
          "username": "$username",
          "password": "$password",
        }));
    try {
      return ApiResponse.completed(UserInfo.fromJson(response));
    } on DioError catch (err) {
      return ApiResponse.error(err.error);
    }
  }
}

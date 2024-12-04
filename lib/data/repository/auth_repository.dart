import 'package:postervibe/data/model/check_user_register_model.dart';
import 'package:postervibe/data/model/login_model.dart';
import 'package:postervibe/data/model/refresh_token_model.dart';
import 'package:postervibe/data/model/user_register_model.dart';

import 'package:postervibe/data/network/api/auth_api.dart';
import 'package:postervibe/data/network/dio_exception.dart';

import 'package:dio/dio.dart';

class AuthRepository {
  final AuthenticationApi authenticationApi;

  AuthRepository(this.authenticationApi);

  Future<CheckUserRegisterModel> checkUser(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await authenticationApi.checkUser(requestParam);
      return CheckUserRegisterModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<UserRegisterModel> signUpUser(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await authenticationApi.signUpUser(requestParam);
      return UserRegisterModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<LoginModel> loginUser(Map<String, dynamic>? requestParam) async {
    try {
      final response = await authenticationApi.loginUser(requestParam);
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String?> refreshToken() async {
    try {
      final response = await authenticationApi.refreshToken();
      return RefreshTokenModel.fromJson(response.data).Result!.RefreshToken;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

    Future<String?> myBusinessList() async {
    try {
      final response = await authenticationApi.refreshToken();
      return RefreshTokenModel.fromJson(response.data).Result!.RefreshToken;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

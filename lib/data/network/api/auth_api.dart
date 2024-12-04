import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';

import 'package:dio/dio.dart';

class AuthenticationApi {
  final DioClient dioClient;

  AuthenticationApi({required this.dioClient});

  Future<Response> checkUser(Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.checkUserRegister,
        data: requestParam,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loginUser(Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.loginUser,
        data: requestParam,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> signUpUser(Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.signUpUser,
        data: requestParam,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> refreshToken() async {
    try {
      final Response response = await dioClient.post(
        Endpoints.refreshToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

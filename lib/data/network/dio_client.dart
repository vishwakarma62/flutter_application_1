import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:postervibe/core/app_prefs.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/utils/app_config.dart';

import 'package:postervibe/data/model/refresh_token_model.dart';
import 'package:postervibe/data/network/api/constant/endpoints.dart';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  // dio instance
  final Dio _dio;

  DioClient(this._dio) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
    _dio
      ..options.baseUrl = AppConfig.baseUrl
      ..options.connectTimeout = const Duration(seconds: 100)
      ..options.receiveTimeout = const Duration(seconds: 100)
      ..options.responseType = ResponseType.json;
      

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = GetStorage();
          String? jwtToken = prefs.read(Prefs.jwtToken);
          options.headers['authorization'] = 'Bearer $jwtToken';
          return handler.next(options);
        },
        // ignore: deprecated_member_use
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
            Get.snackbar(AppConfig.snackbarErrorTitle, e.response.toString());
            try {
              final prefs = GetStorage();
              String? jwtToken = prefs.read(Prefs.jwtToken);
              String? refreshToken = prefs.read(Prefs.refreshToken);
              final formData = FormData.fromMap({
                'jwtToken': jwtToken,
                'refreshToken': refreshToken,
              });
              final Response response =
                  await _dio.post(Endpoints.refreshToken, data: formData);
              RefreshTokenModel newAuthToken =
                  RefreshTokenModel.fromJson(response.data);
              final Map<String, dynamic> authToken = {
                'jwtToken': newAuthToken.Result!.JwtToken,
                'refreshToken': newAuthToken.Result!.RefreshToken,
              };
              LocalStorage.setAuthToken(authToken);
              e.requestOptions.headers['authorization'] =
                  'Bearer ${newAuthToken.Result!.JwtToken}';
              return handler.resolve(await _dio.fetch(e.requestOptions));
            } catch (error) {
              rethrow;
            }
          } else {
            Get.snackbar(AppConfig.snackbarErrorTitle, AppConfig.anErrorOccurred);
          }
        },
      ),
    );
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Perform a GET request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';

import 'package:dio/dio.dart';

class AppVersionApi {
  final DioClient dioClient;

  AppVersionApi({required this.dioClient});

   Future<Response> appVersion() async {
    try {
      final Response response = await dioClient.post(
        Endpoints.appVersion,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

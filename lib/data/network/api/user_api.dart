import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';

import 'package:dio/dio.dart';

class UserAPi {
  final DioClient dioClient;

  UserAPi({required this.dioClient});

  Future<Response> profileUpdate(FormData requestParam) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.profileUpdate,
        data: requestParam,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

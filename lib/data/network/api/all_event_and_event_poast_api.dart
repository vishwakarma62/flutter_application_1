import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';

import 'package:dio/dio.dart';

class AllEventAndPostApi {
  final DioClient dioClient;

  AllEventAndPostApi({required this.dioClient});

  Future<Response> allEventAndPost(Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.getEventList,
        data: requestParam,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

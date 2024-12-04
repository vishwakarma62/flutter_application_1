import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';

import 'package:dio/dio.dart';

class SearchEventApi {
  final DioClient dioClient;

  SearchEventApi({required this.dioClient});

  Future<Response> searchEvent(Map<String, dynamic>? requestParam) async {
    try {
      final Response response =
          await dioClient.post(Endpoints.getEventList, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

    Future<Response> eventPostByEventId(Map<String, dynamic>? requestParam) async {
    try {
      final Response response =
          await dioClient.post(Endpoints.getEventPostList, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

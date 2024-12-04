import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';

import 'package:dio/dio.dart';

class MyPostApi {
  final DioClient dioClient;

  MyPostApi({required this.dioClient});

  Future<Response> downloadPost(FormData requestParam) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.downloadPost,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: requestParam,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getMyPost() async {
    try {
      final Response response = await dioClient.post(
        Endpoints.getMyPost,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteMyPost(Map<String, dynamic>? requestParam) async {
    try {
      final Response response =
          await dioClient.post(Endpoints.deletePost, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getBytes(String url) async {
    Dio dio = Dio();
    try {
      final Response response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

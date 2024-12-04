import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';
import 'package:dio/dio.dart';

class DashBoardApi {
  final DioClient dioClient;

  DashBoardApi({required this.dioClient});

  Future<Response> getDashBoardEventPostList() async {
    try {
      final Response response = await dioClient.post(
        Endpoints.getDashBoardEventPostList,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getBannerList() async {
    try {
      final Response response =
          await dioClient.post(Endpoints.bannerList, data: {});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCategoryList() async {
    try {
      final Response response = await dioClient.post(
        Endpoints.getCategoruList,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getTodaysEventList(
      Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.GetTodaysEventList, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getEventPostByEventId(
      Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.GetEventPostByEventId, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getEventPostByCategory(
      Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.getEventList, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

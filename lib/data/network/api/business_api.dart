
import 'package:postervibe/data/network/api/constant/endpoints.dart';
import 'package:postervibe/data/network/dio_client.dart';
import 'package:dio/dio.dart';

class BusinessApi {
  final DioClient dioClient;

  BusinessApi({required this.dioClient});

  Future<Response> myBusiness() async {
    try {
      final Response response = await dioClient.post(
        Endpoints.getMyBusinessList,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> businessCategoryName() async {
    try {
      final Response response = await dioClient.post(
        Endpoints.getBusinessCategoryNameList,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addBusiness(FormData requestParam) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.addAndUpdateBusiness, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateBusiness(FormData requestParam) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.addAndUpdateBusiness, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteBusiness(Map<String, dynamic>? requestParam) async {
    try {
      final Response response =
          await dioClient.post(Endpoints.deleteBusiness, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> selectBusiness(FormData requestParam) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.addAndUpdateBusiness, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getSelectedBusiness(Map<String, dynamic>? requestParam) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.businessById, data: requestParam);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

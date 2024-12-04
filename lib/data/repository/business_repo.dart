import 'package:postervibe/data/model/add_and_update_business_model.dart';
import 'package:postervibe/data/model/business_by_id_model.dart';

import 'package:postervibe/data/model/delete_business_model.dart';
import 'package:postervibe/data/model/get_business_category_list_model.dart';

import 'package:postervibe/data/model/my_business_list_model.dart';

import 'package:postervibe/data/network/api/business_api.dart';


import 'package:postervibe/data/network/dio_exception.dart';


import 'package:dio/dio.dart';

class BusinessRepository {
  BusinessApi businessApi;

  BusinessRepository(this.businessApi);

  Future<MyBusinessListModel> getMyBusinessList() async {
    try {
      final response = await businessApi.myBusiness();

      return MyBusinessListModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<BusinessCategoryNameList> getBusinessCategoryList() async {
    try {
      final response = await businessApi.businessCategoryName();

      return BusinessCategoryNameList.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<AddAndUpdateBusinessModel> addBusiness(FormData requestParam) async {
    try {
      final response = await businessApi.addBusiness(requestParam);

      return AddAndUpdateBusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<AddAndUpdateBusinessModel> updateBusiness(
      FormData requestParam) async {
    try {
      final response = await businessApi.updateBusiness(requestParam);

      return AddAndUpdateBusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<DeleteBusinessModel> deleteBusiness(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await businessApi.deleteBusiness(requestParam);

      return DeleteBusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<AddAndUpdateBusinessModel> selectBusiness(
      FormData requestParam) async {
    try {
      final response = await businessApi.selectBusiness(requestParam);

      return AddAndUpdateBusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<BusinessById> getSelectedBusiness(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await businessApi.getSelectedBusiness(requestParam);
      print(response);

      return BusinessById.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

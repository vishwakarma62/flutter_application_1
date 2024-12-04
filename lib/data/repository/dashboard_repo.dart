import 'package:postervibe/data/model/banner.dart';
import 'package:postervibe/data/model/get_category_list_model.dart';
import 'package:postervibe/data/model/event_and_posts_model.dart';
import 'package:postervibe/data/model/get_event_post_list_by_event_id_model.dart';

import 'package:postervibe/data/model/dashboard_event_and_event_post_model.dart';
import 'package:postervibe/data/model/today_event_list_model.dart';

import 'package:postervibe/data/network/api/dashboard_api.dart';

import 'package:postervibe/data/network/dio_exception.dart';

import 'package:dio/dio.dart';

class DashBoardRepository {
  DashBoardApi dashBoardApi;

  DashBoardRepository(this.dashBoardApi);

  Future<BannerModel> getBannerList() async {
    try {
      final response = await dashBoardApi.getBannerList();

      return BannerModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<DashBoardEventAndEventPostModel>
      getDashBoardEventAndEventPost() async {
    try {
      final response = await dashBoardApi.getDashBoardEventPostList();
      return DashBoardEventAndEventPostModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<GetCategoryModel> getCategoryList() async {
    try {
      final response = await dashBoardApi.getCategoryList();

      return GetCategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<TodayEventListModel> getTodaysEventList(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await dashBoardApi.getTodaysEventList(requestParam);

      return TodayEventListModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<GetEventPostByEventIdModel> getEventPostByCategoryEvent(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await dashBoardApi.getEventPostByEventId(requestParam);
      return GetEventPostByEventIdModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<EventAndPostsModel> getEventAndPostByCategory(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await dashBoardApi.getEventPostByCategory(requestParam);
      return EventAndPostsModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

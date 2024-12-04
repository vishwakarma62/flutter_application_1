
import 'package:postervibe/data/model/event_and_posts_model.dart';




import 'package:postervibe/data/network/api/search_event_api.dart';
import 'package:postervibe/data/network/dio_exception.dart';

import 'package:dio/dio.dart';

class SearchRepository {
  final SearchEventApi searchEventApi;

  SearchRepository(this.searchEventApi);

  Future<EventAndPostsModel> searchEvent(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await searchEventApi.searchEvent(requestParam);
      return EventAndPostsModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

    Future<EventAndPostsModel> eventPostByEventId(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await searchEventApi.eventPostByEventId(requestParam);
      return EventAndPostsModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

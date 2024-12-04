

import 'package:postervibe/data/model/event_and_posts_model.dart';


import 'package:postervibe/data/network/api/all_event_and_event_poast_api.dart';


import 'package:postervibe/data/network/dio_exception.dart';

import 'package:dio/dio.dart';

class AllEventAndPostRepo {
  final AllEventAndPostApi allEventAndPostApi;

  AllEventAndPostRepo(this.allEventAndPostApi);

  
  Future<EventAndPostsModel> allEventAndPost(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await allEventAndPostApi.allEventAndPost(requestParam);
      return EventAndPostsModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  
}

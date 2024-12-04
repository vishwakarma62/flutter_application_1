

import 'package:postervibe/data/model/delete_my_post_model.dart';
import 'package:postervibe/data/model/download_image_model.dart';

import 'package:postervibe/data/model/get_my_post_model.dart';


import 'package:postervibe/data/network/api/my_post_api.dart';

import 'package:postervibe/data/network/dio_exception.dart';

import 'package:dio/dio.dart';

class MyPostRepo {
  final MyPostApi myPostApi;

  MyPostRepo(this.myPostApi);

  Future<DownloadPostModel> downloadPost(FormData requestParam) async {
    try {
      final response = await myPostApi.downloadPost(requestParam);
      return DownloadPostModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<GetMyPostModel> getMyPost() async {
    try {
      final response = await myPostApi.getMyPost();
      return GetMyPostModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<DeleteMyPostModel> deleteMyPost(
      Map<String, dynamic>? requestParam) async {
    try {
      final response = await myPostApi.deleteMyPost(requestParam);
      return DeleteMyPostModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Map<String, dynamic>?> getbytes(String url) async {
    try {
      final Response response = await myPostApi.getBytes(url);
      return {'byteData': response.data, 'response': response.statusCode};
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

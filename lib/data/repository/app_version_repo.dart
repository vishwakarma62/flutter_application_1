import 'package:postervibe/data/model/app_version_model.dart';

import 'package:postervibe/data/network/api/app_version/app_version_api.dart';


import 'package:postervibe/data/network/dio_exception.dart';

import 'package:dio/dio.dart';

class AppVersionRepo {
  final AppVersionApi appVersionApi;

  AppVersionRepo(this.appVersionApi);

  Future<SettingModel> version(
     ) async {
    try {
      final response = await appVersionApi.appVersion();
      return SettingModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }



 



  
}

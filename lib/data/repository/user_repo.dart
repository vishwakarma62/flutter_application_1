import 'package:postervibe/data/model/profile_update_model.dart';

import 'package:postervibe/data/network/api/user_api.dart';
import 'package:postervibe/data/network/dio_exception.dart';

import 'package:dio/dio.dart';

class USerRespository {
  final UserAPi userRespository;

  USerRespository(this.userRespository);

  Future<ProfileUpdate> updateProfile(
     FormData requestParam) async {
    try {
      final response = await userRespository.profileUpdate(requestParam);
      return ProfileUpdate.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

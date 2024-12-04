// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserRegisterModel _$CheckUserRegisterModelFromJson(
        Map<String, dynamic> json) =>
    CheckUserRegisterModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$CheckUserRegisterModelToJson(
        CheckUserRegisterModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: json['data'] as bool?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

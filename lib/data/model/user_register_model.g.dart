// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegisterModel _$UserRegisterModelFromJson(Map<String, dynamic> json) =>
    UserRegisterModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : RegistrationResult.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$UserRegisterModelToJson(UserRegisterModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

RegistrationResult _$RegistrationResultFromJson(Map<String, dynamic> json) =>
    RegistrationResult(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      countryCode: json['countryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      jwtToken: json['jwtToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$RegistrationResultToJson(RegistrationResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'jwtToken': instance.jwtToken,
      'refreshToken': instance.refreshToken,
    };

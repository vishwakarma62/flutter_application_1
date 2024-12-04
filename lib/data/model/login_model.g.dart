// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : LoginResult.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      id: json['id'] as String? ?? "",
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String?,
      countryCode: json['countryCode'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String? ?? '',
      jwtToken: json['jwtToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? "",
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'jwtToken': instance.jwtToken,
      'refreshToken': instance.refreshToken,
    };

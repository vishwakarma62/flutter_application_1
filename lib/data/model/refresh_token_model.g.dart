// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenModel _$RefreshTokenModelFromJson(Map<String, dynamic> json) =>
    RefreshTokenModel(
      json['StatusCode'] as int,
      json['Message'] as String,
      json['Result'] == null
          ? null
          : RefreshTokenData.fromJson(json['Result'] as Map<String, dynamic>),
      json['IsSuccess'] as bool,
    );

Map<String, dynamic> _$RefreshTokenModelToJson(RefreshTokenModel instance) =>
    <String, dynamic>{
      'StatusCode': instance.StatusCode,
      'Message': instance.Message,
      'Result': instance.Result,
      'IsSuccess': instance.IsSuccess,
    };

RefreshTokenData _$RefreshTokenDataFromJson(Map<String, dynamic> json) =>
    RefreshTokenData(
      json['JwtToken'] as String,
      json['RefreshToken'] as String,
    );

Map<String, dynamic> _$RefreshTokenDataToJson(RefreshTokenData instance) =>
    <String, dynamic>{
      'JwtToken': instance.JwtToken,
      'RefreshToken': instance.RefreshToken,
    };

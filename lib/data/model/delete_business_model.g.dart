// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBusinessModel _$DeleteBusinessModelFromJson(Map<String, dynamic> json) =>
    DeleteBusinessModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$DeleteBusinessModelToJson(
        DeleteBusinessModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_business_category_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCategoryNameList _$BusinessCategoryNameListFromJson(
        Map<String, dynamic> json) =>
    BusinessCategoryNameList(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$BusinessCategoryNameListToJson(
        BusinessCategoryNameList instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BusinessCategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

BusinessCategoryData _$BusinessCategoryDataFromJson(
        Map<String, dynamic> json) =>
    BusinessCategoryData(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BusinessCategoryDataToJson(
        BusinessCategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_category_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoryModel _$GetCategoryModelFromJson(Map<String, dynamic> json) =>
    GetCategoryModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$GetCategoryModelToJson(GetCategoryModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      categoryName: json['categoryName'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      categoryImage: json['categoryImage'] as String?,
      categoryImageThumbnail: json['categoryImageThumbnail'] as String?,
      displayOrder: json['displayOrder'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryImage': instance.categoryImage,
      'categoryImageThumbnail': instance.categoryImageThumbnail,
      'displayOrder': instance.displayOrder,
      'status': instance.status,
      'categoryName': instance.categoryName,
    };

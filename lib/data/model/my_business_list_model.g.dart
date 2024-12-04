// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_business_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBusinessListModel _$MyBusinessListModelFromJson(Map<String, dynamic> json) =>
    MyBusinessListModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$MyBusinessListModelToJson(
        MyBusinessListModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => myBusinessData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

myBusinessData _$DataFromJson(Map<String, dynamic> json) => myBusinessData(
      id: json['id'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      businessCategoryName: json['businessCategoryName']  as String? ?? '',
      businessCategoryId: json['businessCategoryId'] as String? ?? '',
      businessName: json['businessName'] as String? ?? '',
      phoneNumber1: json['phoneNumber1'] as String? ?? '',
      phoneNumber2: json['phoneNumber2'] as String? ?? '',
      email: json['email'] as String? ?? '',
      website: json['website'] as String? ?? '',
      isDefault: json['isDefault'] as bool?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$DataToJson(myBusinessData instance) => <String, dynamic>{
      'id': instance.id,
      'logo': instance.logo,
      'categoryName': instance.businessCategoryName,
      'businessCategoryId': instance.businessCategoryId,
      'businessName': instance.businessName,
      'phoneNumber1': instance.phoneNumber1,
      'phoneNumber2': instance.phoneNumber2,
      'email': instance.email,
      'website': instance.website,
      'isDefault': instance.isDefault,
      'address': instance.address,
    };

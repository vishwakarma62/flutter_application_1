import 'package:json_annotation/json_annotation.dart';

part 'my_business_list_model.g.dart';

@JsonSerializable()
class MyBusinessListModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  MyBusinessListModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory MyBusinessListModel.fromJson(Map<String, dynamic> json) =>
      _$MyBusinessListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyBusinessListModelToJson(this);
}

@JsonSerializable()
class Result {
  List<myBusinessData>? data;

  Result({
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class myBusinessData {
  String? id;
  String? logo;
  String? businessCategoryId;
  String? businessCategoryName;
  String? businessName;
  String? phoneNumber1;
  String? phoneNumber2;
  String? email;
  String? website;
  bool? isDefault;
  String? address;

  myBusinessData({
    this.id,
    this.logo,
    this.businessCategoryName,
    this.businessCategoryId,
    this.businessName,
    this.phoneNumber1,
    this.phoneNumber2,
    this.email,
    this.website,
    this.isDefault,
    this.address,
  });

  factory myBusinessData.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

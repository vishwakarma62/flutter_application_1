import 'package:json_annotation/json_annotation.dart';

part 'get_business_category_list_model.g.dart';

@JsonSerializable()
class BusinessCategoryNameList {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  BusinessCategoryNameList({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory BusinessCategoryNameList.fromJson(Map<String, dynamic> json) =>
      _$BusinessCategoryNameListFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessCategoryNameListToJson(this);
}

@JsonSerializable()
class Result {
  List<BusinessCategoryData>? data;

  Result({
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class BusinessCategoryData {
  String? id;
  String? name;

  BusinessCategoryData({
    this.id,
    this.name,
  });

  factory BusinessCategoryData.fromJson(Map<String, dynamic> json) =>
      _$BusinessCategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessCategoryDataToJson(this);
}

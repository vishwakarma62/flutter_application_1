import 'package:json_annotation/json_annotation.dart';

part 'get_category_list_model.g.dart';

@JsonSerializable()
class GetCategoryModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  GetCategoryModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoryModelToJson(this);
}

@JsonSerializable()
class Result {
  List<CategoryData>? data;

  Result({this.data});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class CategoryData {
  String? id;
  String? name;
  String? categoryImage;
  String? categoryImageThumbnail;
  int? displayOrder;
  String? status;
  String? categoryName;

  CategoryData({
    this.categoryName,
    this.id,
    this.name,
    this.categoryImage,
    this.categoryImageThumbnail,
    this.displayOrder,
    this.status,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}

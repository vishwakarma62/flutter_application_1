import 'package:json_annotation/json_annotation.dart';

part 'delete_business_model.g.dart';

@JsonSerializable()
class DeleteBusinessModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  DeleteBusinessModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory DeleteBusinessModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteBusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteBusinessModelToJson(this);
}

@JsonSerializable()
class Result {
  String? data;

  Result({
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

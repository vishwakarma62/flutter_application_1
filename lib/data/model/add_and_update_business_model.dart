import 'package:json_annotation/json_annotation.dart';

part 'add_and_update_business_model.g.dart';

@JsonSerializable()
class AddAndUpdateBusinessModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  AddAndUpdateBusinessModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory AddAndUpdateBusinessModel.fromJson(Map<String, dynamic> json) =>
      _$AddAndUpdateBusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddAndUpdateBusinessModelToJson(this);
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

import 'package:json_annotation/json_annotation.dart';

part 'check_user_register_model.g.dart';

@JsonSerializable()
class CheckUserRegisterModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  CheckUserRegisterModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory CheckUserRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$CheckUserRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserRegisterModelToJson(this);
}

@JsonSerializable()
class Result {
  bool? data;

  Result({this.data});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

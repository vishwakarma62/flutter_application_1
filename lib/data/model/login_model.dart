
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  int? statusCode;
  String? message;
  LoginResult? result;
  bool? isSuccess;

  LoginModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class LoginResult {
  String? id;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? profileImage;
  String? jwtToken;
  String? refreshToken;

  LoginResult({
    this.id,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.jwtToken,
    this.refreshToken,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

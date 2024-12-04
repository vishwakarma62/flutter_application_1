import 'package:json_annotation/json_annotation.dart';

part 'user_register_model.g.dart';

@JsonSerializable()
class UserRegisterModel {
  int? statusCode;
  String? message;
  RegistrationResult? result;
  bool? isSuccess;

  UserRegisterModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterModelToJson(this);
}

@JsonSerializable()
class RegistrationResult {
  String? id;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? jwtToken;
  String? refreshToken;

  RegistrationResult({
    this.id,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.jwtToken,
    this.refreshToken,
  });

  factory RegistrationResult.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResultFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResultToJson(this);
}

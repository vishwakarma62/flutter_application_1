import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_model.g.dart';

@JsonSerializable()
class RefreshTokenModel {
  RefreshTokenModel(this.StatusCode, this.Message, this.Result, this.IsSuccess);

  int StatusCode;
  String Message;
  RefreshTokenData? Result;
  bool IsSuccess;

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenModelToJson(this);
}

@JsonSerializable()
class RefreshTokenData {
  RefreshTokenData(this.JwtToken, this.RefreshToken);

  String JwtToken;
  String RefreshToken;

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenDataToJson(this);
}

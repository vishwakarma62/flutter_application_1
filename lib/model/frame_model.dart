import 'package:flutter/material.dart';

class FrameModel {
  String frameID, frameUrl;
  Positions? position;

  FrameModel({
    required this.frameID,
    required this.frameUrl,
    this.position,
  });
}

class Positions {
  Side? address;
  Side? companyName;
  Side? email;
  Side? logo;
  Side? mobileNumber;
  Side? website;

  Positions({
    this.address,
    this.companyName,
    this.email,
    this.logo,
    this.mobileNumber,
    this.website,
  });

  Positions.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Side.fromJson(json['address']) : null;
    companyName = json['company_name'] != null
        ? Side.fromJson(json['company_name'])
        : null;
    email = json['email'] != null ? Side.fromJson(json['email']) : null;
    logo = json['logo'] != null ? Side.fromJson(json['logo']) : null;
    mobileNumber = json['mobile_number'] != null
        ? Side.fromJson(json['mobile_number'])
        : null;
    website =
        json['website'] != null ? Side.fromJson(json['website']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (companyName != null) {
      data['company_name'] = companyName!.toJson();
    }
    if (email != null) {
      data['email'] = email!.toJson();
    }
    if (logo != null) {
      data['logo'] = logo!.toJson();
    }
    if (mobileNumber != null) {
      data['mobile_number'] = mobileNumber!.toJson();
    }
    if (website != null) {
      data['website'] = website!.toJson();
    }
    return data;
  }
}

class Side {
  String? top;
  String? bottom;
  String? left;
  String? right;
  String? fontSize;
  double? size;
  String? maxLine;
  Color? fontColor;
  String? iconSize;
  MainAxisAlignment? alignment;
  Color? color;
 
  Side({
    this.alignment,
    this.bottom,
    this.left,
    this.right,
    this.color,
    this.top,
    this.fontColor,
    this.size,
    this.iconSize,
    this.maxLine,
    this.fontSize,
  });

  Side.fromJson(Map<String, dynamic> json) {
    top = json['top'];
    bottom = json['bottom'];
    left = json['left'];
    right = json['right'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['top'] = top;
    data['bottom'] = bottom;
    data['left'] = left;
    data['right'] = right;
    return data;
  }
}

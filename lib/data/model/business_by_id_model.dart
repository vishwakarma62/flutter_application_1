class BusinessById {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  BusinessById({this.statusCode, this.message, this.result, this.isSuccess});

  BusinessById.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['isSuccess'] = isSuccess;
    return data;
  }
}

class Result {
  BusinessData? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? BusinessData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BusinessData {
  String? userId;
  String? user;
  String? businessName;
  String? tagLine;
  String? logo;
  String? website;
  String? address;
  String? email;
  String? phoneNumber1;
  String? phoneNumber2;
  String? businessCategoryId;
  String? businessCategory;
  bool? isDefault;
  String? status;
  String? created;
  String? createdBy;
  String? lastModified;
  String? lastModifiedBy;
  String? id;

  BusinessData(
      {this.userId,
      this.user,
      this.businessName,
      this.tagLine,
      this.logo,
      this.website,
      this.address,
      this.email,
      this.phoneNumber1,
      this.phoneNumber2,
      this.businessCategoryId,
      this.businessCategory,
      this.isDefault,
      this.status,
      this.created,
      this.createdBy,
      this.lastModified,
      this.lastModifiedBy,
      this.id});

  BusinessData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    user = json['user'];
    businessName = json['businessName'];
    tagLine = json['tagLine'];
    logo = json['logo'];
    website = json['website'];
    address = json['address'];
    email = json['email'];
    phoneNumber1 = json['phoneNumber1'];
    phoneNumber2 = json['phoneNumber2'];
    businessCategoryId = json['businessCategoryId'];
    businessCategory = json['businessCategory'];
    isDefault = json['isDefault'];
    status = json['status'];
    created = json['created'];
    createdBy = json['createdBy'];
    lastModified = json['lastModified'];
    lastModifiedBy = json['lastModifiedBy'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['user'] = user;
    data['businessName'] = businessName;
    data['tagLine'] = tagLine;
    data['logo'] = logo;
    data['website'] = website;
    data['address'] = address;
    data['email'] = email;
    data['phoneNumber1'] = phoneNumber1;
    data['phoneNumber2'] = phoneNumber2;
    data['businessCategoryId'] = businessCategoryId;
    data['businessCategory'] = businessCategory;
    data['isDefault'] = isDefault;
    data['status'] = status;
    data['created'] = created;
    data['createdBy'] = createdBy;
    data['lastModified'] = lastModified;
    data['lastModifiedBy'] = lastModifiedBy;
    data['id'] = id;
    return data;
  }
}

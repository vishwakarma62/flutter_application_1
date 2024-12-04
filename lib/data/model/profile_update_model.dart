class ProfileUpdate {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  ProfileUpdate({this.statusCode, this.message, this.result, this.isSuccess});

  ProfileUpdate.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}

class Result {
  String? id;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? profileImage;
  String? status;

  Result(
      {this.id,
      this.firstName,
      this.lastName,
      this.countryCode,
      this.phoneNumber,
      this.profileImage,
      this.status});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profileImage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['profileImage'] = this.profileImage;
    data['status'] = this.status;
    return data;
  }
}
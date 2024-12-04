class BannerModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  BannerModel({this.statusCode, this.message, this.result, this.isSuccess});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  int? total;
  int? limit;
  int? page;
  List<BannerData>? list;

  Result({this.total, this.limit, this.page, this.list});

  Result.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      list = <BannerData>[];
      json['list'].forEach((v) {
        list!.add(BannerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['limit'] = limit;
    data['page'] = page;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerData {
  String? id;
  String? title;
  String? imagePath;
  int? sequenceNumber;
  Null status;

  BannerData(
      {this.id, this.title, this.imagePath, this.sequenceNumber, this.status});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imagePath = json['bannerImage'];
    sequenceNumber = json['sequenceNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imagePath'] = imagePath;
    data['sequenceNumber'] = sequenceNumber;
    data['status'] = status;
    return data;
  }
}

class GetMyPostModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  GetMyPostModel({this.statusCode, this.message, this.result, this.isSuccess});

  GetMyPostModel.fromJson(Map<String, dynamic> json) {
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
  List<MyDownloadedPost>? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyDownloadedPost>[];
      json['data'].forEach((v) {
        data!.add(new MyDownloadedPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyDownloadedPost {
  String? id;
  String? userId;
  String? postImage;
  String? postImageThumbnail;
  String? postVideo;

  MyDownloadedPost(
      {this.id,
      this.userId,
      this.postImage,
      this.postImageThumbnail,
      this.postVideo});

  MyDownloadedPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    postImage = json['postImage'];
    postImageThumbnail = json['postImageThumbnail'];
    postVideo = json['postVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['postImage'] = this.postImage;
    data['postImageThumbnail'] = this.postImageThumbnail;
    data['postVideo'] = this.postVideo;
    return data;
  }
}
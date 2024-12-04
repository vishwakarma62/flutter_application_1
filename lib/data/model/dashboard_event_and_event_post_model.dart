import 'package:json_annotation/json_annotation.dart';

part 'dashboard_event_and_event_post_model.g.dart';

@JsonSerializable()
class DashBoardEventAndEventPostModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  DashBoardEventAndEventPostModel({this.statusCode, this.message, this.result, this.isSuccess});

  factory DashBoardEventAndEventPostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class Result {
  List<DashBoardEventAndEventPOstData>? data;

  Result({this.data});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class DashBoardEventAndEventPOstData {
  String? id;
  String? eventName;
  int? count;
  List<EventPostByEventList>? eventPostByEventList;

  DashBoardEventAndEventPOstData({this.id, this.eventName, this.count, this.eventPostByEventList});

  factory DashBoardEventAndEventPOstData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}

@JsonSerializable()
class EventPostByEventList {
  String? id;
  String? image;
  String? eventPostImageThumbnail;

  EventPostByEventList({this.id, this.image, this.eventPostImageThumbnail});

  factory EventPostByEventList.fromJson(Map<String, dynamic> json) =>
      _$EventPostByEventListFromJson(json);

  Map<String, dynamic> toJson() => _$EventPostByEventListToJson(this);
}

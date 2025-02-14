
import 'package:json_annotation/json_annotation.dart';

part 'get_event_post_list_by_event_id_model.g.dart'; // This file will be generated by the build runner

@JsonSerializable()
class GetEventPostByEventIdModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  GetEventPostByEventIdModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory GetEventPostByEventIdModel.fromJson(Map<String, dynamic> json) =>
      _$GetEventPostByEventIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetEventPostByEventIdModelToJson(this);
}

@JsonSerializable()
class Result {
  Data? data;

  Result({this.data});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Data {
  int? total;
  int? limit;
  int? page;
  List<EventPostByEventIdData>? list;

  Data({this.total, this.limit, this.page, this.list});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class EventPostByEventIdData {
  String? id;
  String? eventId;
  String? eventName;
  String? eventPostImage;
  String? eventPostVideo;
  String? eventPostImageThumbnail;
  String? eventPostVideoThumbnail;
  String? tags;
  String? language;
  bool? isTrending;
  String? status;

  EventPostByEventIdData({
    this.id,
    this.eventId,
    this.eventName,
    this.eventPostImage,
    this.eventPostVideo,
    this.eventPostImageThumbnail,
    this.eventPostVideoThumbnail,
    this.tags,
    this.language,
    this.isTrending,
    this.status,
  });

  factory EventPostByEventIdData.fromJson(Map<String, dynamic> json) =>
      _$EventPostByEventIdDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventPostByEventIdDataToJson(this);
}

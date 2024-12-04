import 'package:json_annotation/json_annotation.dart';

part 'today_event_list_model.g.dart';

@JsonSerializable()
class TodayEventListModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  TodayEventListModel({
    this.statusCode,
    this.message,
    this.result,
    this.isSuccess,
  });

  factory TodayEventListModel.fromJson(Map<String, dynamic> json) =>
      _$TodayEventListModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodayEventListModelToJson(this);
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
  List<EventList>? list;

  Data({this.total, this.limit, this.page, this.list});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class EventList {
  String? id;
  String? eventDate;
  String? name;
  String? eventImage;
  String? eventImageThumbnail;
  bool? isOnHomepage;
  String? status;
  List? categoryList;
  List? eventPostList;

  EventList({
    this.id,
    this.eventDate,
    this.name,
    this.eventImage,
    this.eventImageThumbnail,
    this.isOnHomepage,
    this.status,
    this.categoryList = const [],
    this.eventPostList = const [],
  });

  factory EventList.fromJson(Map<String, dynamic> json) =>
      _$EventListFromJson(json);

  Map<String, dynamic> toJson() => _$EventListToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_event_and_event_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashBoardEventAndEventPostModel _$PostModelFromJson(
        Map<String, dynamic> json) =>
    DashBoardEventAndEventPostModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$PostModelToJson(
        DashBoardEventAndEventPostModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DashBoardEventAndEventPOstData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

DashBoardEventAndEventPOstData _$PostDataFromJson(Map<String, dynamic> json) => DashBoardEventAndEventPOstData(
      id: json['id'] as String?,
      eventName: json['eventName'] as String?,
      count: json['count'] as int?,
      eventPostByEventList: (json['eventPostByEventList'] as List<dynamic>?)
          ?.map((e) => EventPostByEventList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostDataToJson(DashBoardEventAndEventPOstData instance) => <String, dynamic>{
      'id': instance.id,
      'eventName': instance.eventName,
      'count': instance.count,
      'eventPostByEventList': instance.eventPostByEventList,
    };

EventPostByEventList _$EventPostByEventListFromJson(
        Map<String, dynamic> json) =>
    EventPostByEventList(
      id: json['id'] as String?,
      image: json['image'] as String?,
      eventPostImageThumbnail: json['eventPostImageThumbnail'] as String?,
    );

Map<String, dynamic> _$EventPostByEventListToJson(
        EventPostByEventList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'eventPostImageThumbnail': instance.eventPostImageThumbnail,
    };

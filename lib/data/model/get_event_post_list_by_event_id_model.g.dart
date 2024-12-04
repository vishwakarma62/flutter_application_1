// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_event_post_list_by_event_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEventPostByEventIdModel _$GetEventPostByEventIdModelFromJson(
        Map<String, dynamic> json) =>
    GetEventPostByEventIdModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$GetEventPostByEventIdModelToJson(
        GetEventPostByEventIdModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'result': instance.result,
      'isSuccess': instance.isSuccess,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      total: json['total'] as int?,
      limit: json['limit'] as int?,
      page: json['page'] as int?,
      list: (json['list'] as List<dynamic>?)
          ?.map(
              (e) => EventPostByEventIdData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'total': instance.total,
      'limit': instance.limit,
      'page': instance.page,
      'list': instance.list,
    };

EventPostByEventIdData _$EventPostByEventIdDataFromJson(
        Map<String, dynamic> json) =>
    EventPostByEventIdData(
      id: json['id'] as String?,
      eventId: json['eventId'] as String?,
      eventName: json['eventName'] as String?,
      eventPostImage: json['eventPostImage'] as String?,
      eventPostVideo: json['eventPostVideo'] as String?,
      eventPostImageThumbnail: json['eventPostImageThumbnail'] as String?,
      eventPostVideoThumbnail: json['eventPostVideoThumbnail'] as String?,
      tags: json['tags'] as String?,
      language: json['language'] as String?,
      isTrending: json['isTrending'] as bool?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$EventPostByEventIdDataToJson(
        EventPostByEventIdData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'eventName': instance.eventName,
      'eventPostImage': instance.eventPostImage,
      'eventPostVideo': instance.eventPostVideo,
      'eventPostImageThumbnail': instance.eventPostImageThumbnail,
      'eventPostVideoThumbnail': instance.eventPostVideoThumbnail,
      'tags': instance.tags,
      'language': instance.language,
      'isTrending': instance.isTrending,
      'status': instance.status,
    };

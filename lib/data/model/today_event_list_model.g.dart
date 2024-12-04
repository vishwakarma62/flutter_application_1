// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_event_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayEventListModel _$TodayEventListModelFromJson(Map<String, dynamic> json) =>
    TodayEventListModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
    );

Map<String, dynamic> _$TodayEventListModelToJson(
        TodayEventListModel instance) =>
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
          ?.map((e) => EventList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'total': instance.total,
      'limit': instance.limit,
      'page': instance.page,
      'list': instance.list,
    };

EventList _$EventListFromJson(Map<String, dynamic> json) => EventList(
      id: json['id'] as String?,
      eventDate: json['eventDate'] as String?,
      name: json['name'] as String?,
      eventImage: json['eventImage'] as String?,
      eventImageThumbnail: json['eventImageThumbnail'] as String?,
      isOnHomepage: json['isOnHomepage'] as bool?,
      status: json['status'] as String?,
      categoryList: json['categoryList'] as List<dynamic>? ?? const [],
      eventPostList: json['eventPostList'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$EventListToJson(EventList instance) => <String, dynamic>{
      'id': instance.id,
      'eventDate': instance.eventDate,
      'name': instance.name,
      'eventImage': instance.eventImage,
      'eventImageThumbnail': instance.eventImageThumbnail,
      'isOnHomepage': instance.isOnHomepage,
      'status': instance.status,
      'categoryList': instance.categoryList,
      'eventPostList': instance.eventPostList,
    };

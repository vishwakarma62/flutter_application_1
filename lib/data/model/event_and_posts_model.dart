class EventAndPostsModel{
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  EventAndPostsModel(
      {this.statusCode, this.message, this.result, this.isSuccess});

  EventAndPostsModel.fromJson(Map<String, dynamic> json) {
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
  Data? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? total;
  int? limit;
  int? page;
  List<EventAndPostData>? list;

  Data({this.total, this.limit, this.page, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    page = json['page'];
    if (json['list'] != null) {
      list = <EventAndPostData >[];
      json['list'].forEach((v) {
        list!.add(EventAndPostData .fromJson(v));
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

class EventAndPostData {
  String? id;
  String? eventDate;
  String? name;
  String? eventImage;
  String? eventImageThumbnail;
  bool? isOnHomepage;
  String? status;
  List<CategoryList>? categoryList;
  List<EventPostList>? eventPostList;
  EventAndPostData (
      {this.id,
      this.eventDate,
      this.name,
      this.eventImage,
      this.eventImageThumbnail,
      this.isOnHomepage,
      this.status,
      this.categoryList,
      this.eventPostList});

  EventAndPostData .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventDate = json['eventDate'];
    name = json['name'];
    eventImage = json['eventImage'];
    eventImageThumbnail = json['eventImageThumbnail'];
    isOnHomepage = json['isOnHomepage'];
    status = json['status'];
    if (json['categoryList'] != null) {
      categoryList = <CategoryList>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
    if (json['eventPostList'] != null) {
      eventPostList = <EventPostList>[];
      json['eventPostList'].forEach((v) {
        eventPostList!.add(EventPostList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventDate'] = eventDate;
    data['name'] = name;
    data['eventImage'] = eventImage;
    data['eventImageThumbnail'] = eventImageThumbnail;
    data['isOnHomepage'] = isOnHomepage;
    data['status'] = status;
    if (categoryList != null) {
      data['categoryList'] = categoryList!.map((v) => v.toJson()).toList();
    }
    if (eventPostList != null) {
      data['eventPostList'] =
          eventPostList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? id;
  String? name;
  String? categoryImage;
  String? categoryImageThumbnail;
  int? displayOrder;
  String? status;

  CategoryList(
      {this.id,
      this.name,
      this.categoryImage,
      this.categoryImageThumbnail,
      this.displayOrder,
      this.status});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryImage = json['categoryImage'];
    categoryImageThumbnail = json['categoryImageThumbnail'];
    displayOrder = json['displayOrder'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['categoryImage'] = categoryImage;
    data['categoryImageThumbnail'] = categoryImageThumbnail;
    data['displayOrder'] = displayOrder;
    data['status'] = status;
    return data;
  }
}

class EventPostList {
  String? id;
  String? eventPostImage;
  String? eventPostImageThumbnail;
  String? tags;
  String? language;
  bool? isTrending;
  String? status;

  EventPostList(
      {this.id,
      this.eventPostImage,
      this.eventPostImageThumbnail,
      this.tags,
      this.language,
      this.isTrending,
      this.status});

  EventPostList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventPostImage = json['eventPostImage'];
    eventPostImageThumbnail = json['eventPostImageThumbnail'];
    tags = json['tags'];
    language = json['language'];
    isTrending = json['isTrending'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventPostImage'] = eventPostImage;
    data['eventPostImageThumbnail'] = eventPostImageThumbnail;
    data['tags'] = tags;
    data['language'] = language;
    data['isTrending'] = isTrending;
    data['status'] = status;
    return data;
  }
}

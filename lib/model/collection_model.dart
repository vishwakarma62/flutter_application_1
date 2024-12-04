import 'package:postervibe/model/post_model.dart';

class CollectionModel {
  String id, name, title;
  List<PostModel1> collectionList;

  CollectionModel({
    required this.id,
    required this.name,
    required this.title,
    required this.collectionList,
  });
}

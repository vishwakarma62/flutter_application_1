class PostModel1 {
  String collectionId, postId, postType, postTitle, postUrl, postLanguage;
  DateTime? createdAt;
  bool postFavStatus, postPremium;

  PostModel1({
    required this.collectionId,
    this.createdAt,
    this.postFavStatus = false,
    required this.postId,
    this.postPremium = false,
    required this.postTitle,
    required this.postType,
    required this.postUrl,
    required this.postLanguage,
  });
}

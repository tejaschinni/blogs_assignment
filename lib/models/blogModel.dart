class BlogModel {
  int? id;
  String? title;
  String? subtitle;
  String? description;
  String? coverImage;
  String? authorID;

  BlogModel(
      {this.authorID,
      this.description,
      this.coverImage,
      this.id,
      this.subtitle,
      this.title});
}

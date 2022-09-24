class BlogModel {
  int? id;
  String? title;
  String? subtitle;
  String? description;
  String? image;
  String? authorID;

  BlogModel(
      {this.authorID,
      this.description,
      this.image,
      this.id,
      this.subtitle,
      this.title});
}

class Category {
  final int id;
  final int parentId;
  final String name;
  final String code;
  final String pageUrl;
  final String featuredImageUrl;

  Category(
      {this.id,
      this.parentId,
      this.name,
      this.code,
      this.pageUrl,
      this.featuredImageUrl});
}

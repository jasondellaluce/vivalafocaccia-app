
class Post {
  final int id;
  final int authorId;
  final String code;
  final String title;
  final String content;
  final String authorName;
  final String pageUrl;
  final String featuredImageUrl;
  final DateTime creationDateTime;
  final DateTime lastUpdateDateTime;

  Post({
    this.id,
    this.authorId,
    this.code,
    this.title,
    this.content,
    this.authorName,
    this.pageUrl,
    this.featuredImageUrl,
    this.creationDateTime,
    this.lastUpdateDateTime
  });

}
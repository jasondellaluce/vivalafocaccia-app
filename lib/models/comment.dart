class Comment {
  final int id;
  final int postId;
  final int authorId;
  final int parentId;
  final String content;
  final String authorName;
  final String authorImageUrl;
  final DateTime creationDateTime;

  Comment(
      {this.id,
      this.postId,
      this.authorId,
      this.parentId,
      this.authorName,
      this.authorImageUrl,
      this.content,
      this.creationDateTime});
}

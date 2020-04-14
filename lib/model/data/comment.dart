
import 'package:meta/meta.dart';

import 'post.dart';

class Comment {
  final int id;
  final int postId;
  final int authorId;
  final String authorName;
  final String authorImageUrl;
  final String content;
  final DateTime creationDateTime;

  Comment(this.id, this.postId, this.authorId, this.authorName,
      this.authorImageUrl, this.content, this.creationDateTime);
}

class CommentDiscussion {
  final Comment value;
  final List<CommentDiscussion> responses;

  CommentDiscussion(this.value, this.responses);

  get hasResponses => responses != null && responses.length > 0;
}

enum CommentOrder {
  date
}

abstract class CommentRepository {

  List<Future<CommentDiscussion>> getManyFromPost({
    @required Post post,
    int offset,
    int count,
    CommentOrder order
  });

  List<Future<CommentDiscussion>> getManyAsDiscussionFromPost({
    @required Post post,
    int offset,
    int count,
    CommentOrder order
  });

  Future<Comment> createComment({
    @required Comment prototype
  });

}
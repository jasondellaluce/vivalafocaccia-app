
import 'user.dart';
import 'package:meta/meta.dart';

import 'post.dart';

class Comment {
  final int id;
  final int postId;
  final int authorId;
  final int parentId;
  final String authorName;
  final String authorImageUrl;
  final String content;
  final DateTime creationDateTime;

  Comment(this.id, this.postId, this.authorId, this.parentId, this.authorName,
      this.authorImageUrl, this.content, this.creationDateTime);
}

class Discussion {
  final Comment value;
  final List<Discussion> responses;

  Discussion(this.value, this.responses);

  get hasResponses => responses != null && responses.length > 0;
  get isRoot => value == null;
}

enum CommentOrder {
  date
}

abstract class CommentRepository {

  Future<Discussion> getDiscussionFromPost({
    @required Post post,
    int offset,
    int count,
    CommentOrder order
  });

  Future<Comment> createComment({
    @required AuthUser user,
    @required Comment prototype
  });

}
import 'dart:async';

import 'package:meta/meta.dart';

import 'category.dart';

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

  Post(
      this.id,
      this.authorId,
      this.code,
      this.title,
      this.content,
      this.authorName,
      this.pageUrl,
      this.featuredImageUrl,
      this.creationDateTime,
      this.lastUpdateDateTime);
}

enum PostOrder { date, relevance }

abstract class PostTypeRepository<PostType extends Post, OrderType> {
  Future<PostType> getFromId({@required int id});

  Future<PostType> getFromCode({@required String code});

  List<Future<PostType>> getMany({int offset, int count, OrderType order});

  List<Future<PostType>> getManyFromCategory(
      {@required Category category, int offset, int count, OrderType order});

  List<Future<PostType>> getManyFromKeyWords(
      {@required String keyWords, int offset, int count, OrderType order});
}

abstract class PostRepository extends PostTypeRepository<Post, PostOrder> {}

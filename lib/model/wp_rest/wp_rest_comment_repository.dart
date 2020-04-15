
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/model/data/comment.dart';
import 'package:app/model/data/post.dart';
import 'package:app/model/data/user.dart';

import 'package:app/errors.dart';

class WPRestCommentRepository implements CommentRepository {

  final String websiteUrl;
  final restRouteBase = "/wp-json/wp/v2";
  final httpClient = http.Client();

  WPRestCommentRepository(this.websiteUrl);

  Comment _parseJson(String jsonBody) {
    Map<String, dynamic> jsonObj = json.decode(jsonBody);
    return Comment(
        int.parse(jsonObj['id'].toString()),
        int.parse(jsonObj['post'].toString()),
        int.parse(jsonObj['author'].toString()),
        int.parse(jsonObj['parent'].toString()),
        jsonObj['author_name'].toString(),
        jsonObj['author_avatar_urls']['48'].toString(),
        jsonObj['content']['rendered'].toString(),
        DateTime.parse(jsonObj['date_gmt']),
    );
  }

  List<Comment> _parseJsonList(String body) {
    List<dynamic> jsonObj = json.decode(body);
    List<Comment> result = new List();
    jsonObj.forEach((element) => result.add(_parseJson(json.encode(element))));
    return result;
  }

  Future<List<Comment>> _doSingleHttpRequest(uri) async {
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      return _parseJsonList(response.body);
    } else {
      throw DataRetrieveError(response.toString());
    }
  }

  @override
  Future<Discussion> getDiscussionFromPost({Post post, offset = 0, count = 100,
    CommentOrder order = CommentOrder.date}) async {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString(),
      'post' : post.id.toString()
    };
    var uri = Uri.https(websiteUrl, restRouteBase + "/comments", query);
    var commentList = await _doSingleHttpRequest(uri);

    List<Discussion> discussionList = commentList
        .map((comment) => Discussion(comment, List())).toList();
    Discussion root = Discussion(null, List());
    for(Discussion discussion in discussionList) {
      if(discussion.value.parentId == 0)
        root.responses.add(discussion);
      else
        discussionList
          .firstWhere((e) => e.value.id == discussion.value.parentId, orElse: () => null)
          ?.responses?.add(discussion);
    }
    return root;
  }

  @override
  Future<Comment> createComment({AuthUser user, Comment prototype,
    Comment parent}) {
    // TODO: implement createComment
    throw UnimplementedError("createComment");
  }

}
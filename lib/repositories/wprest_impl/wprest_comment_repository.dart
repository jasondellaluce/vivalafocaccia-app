
import 'package:app/models/models.dart';
import '../common.dart';
import 'abstract_wprest_repository.dart';
import '../comment_repository.dart';

class WpRestCommentRepository extends AbstractWpRestRepository<Comment>
    implements CommentRepository {
  final String urlBase;
  final String urlEndpoint = "/wp-json/wp/v2/comments";

  WpRestCommentRepository(httpClient, this.urlBase) : super(httpClient);

  @override
  Comment parseJsonMap(Map<String, dynamic> map) {
    return Comment(
      id: int.parse(map['id'].toString()),
      postId: int.parse(map['post'].toString()),
      authorId: int.parse(map['author'].toString()),
      parentId: int.parse(map['parent'].toString()),
      authorName : map['author_name'].toString(),
      authorImageUrl: map['author_avatar_urls']['48'].toString(),
      content : map['content']['rendered'].toString(),
      creationDateTime : DateTime.parse(map['date_gmt']),
    );
  }

  Map<String, dynamic> _formatCommentForCreate(Comment data, User user) {
    return {
      "post" : data?.postId.toString(),
      "parent" : data?.parentId.toString(),
      "author" : user?.id.toString(),
      "author_email" : user.email,
      "author_name" : user.name,
      "content" : {
        "rendered" : data.content
      },
      "date" : DateTime.now().toLocal().toIso8601String(),
      "date_gmt" : DateTime.now().toUtc().toIso8601String()
      // TODO: add IP, user agent,
    };
  }

  String _formatCommentOrderBy(CommentOrderBy order) {
    switch(order) {
      case CommentOrderBy.date: return "date";
      default: return null;
    }
  }

  @override
  Future<Comment> read(CommentSingleReadRequest request) {
    if(request.id != null)
      throw new RepositoryInvalidRequestError("Should specify id");

    String url = urlEndpoint + "/" + request.id.toString();
    return delegateRead(urlBase, url, {}, {});
  }

  @override
  Future<List<Comment>> readMany(CommentMultiReadRequest request) {
    Map<String, String> query = Map();
    query['offset'] = request.readOffset?.toString() ?? null;
    query['per_page'] = request.readCount?.toString() ?? null;
    query['orderby'] = _formatCommentOrderBy(request.orderBy) ?? null;
    query['order'] = formatResultOrderType(request.order) ?? null;

    return delegateReadMany(urlBase, urlEndpoint, query, Map());
  }

  @override
  Future<Comment> create(CommentCreateRequest request) {
    return delegateCreate(urlBase, urlEndpoint,
        _formatCommentForCreate(request.prototype, request.authUser),
        formatAuthUserTokenToHeader(request.authUser));
  }

}
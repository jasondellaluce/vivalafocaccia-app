import 'package:app/models/models.dart';
import 'abstract_wprest_repository.dart';
import '../post_repository.dart';
import '../common.dart';

class WpRestPostRepository extends AbstractWpRestRepository<Post>
    implements PostRepository {
  final String urlBase;
  final String urlEndpoint = "/wp-json/wp/v2/posts";

  WpRestPostRepository(httpClient, this.urlBase) : super(httpClient);

  @override
  parseJsonMap(Map<String, dynamic> map) {
    return Post(
        id: int.parse(map['id'].toString()),
        authorId: int.parse(map['author'].toString()),
        code: map['slug'].toString(),
        title: map['title']['rendered'].toString(),
        content: map['content']['rendered'].toString(),
        authorName: map['author_name'].toString(),
        pageUrl: map['link'].toString(),
        featuredImageUrl: map['featured_image_url'],
        creationDateTime: DateTime.parse(map['date_gmt']),
        lastUpdateDateTime: DateTime.parse(map['modified_gmt']));
  }

  String _formatPostOrderBy(PostOrderBy order) {
    switch (order) {
      case PostOrderBy.date:
        return "date";
      case PostOrderBy.relevance:
        return "relevance";
      default:
        return null;
    }
  }

  @override
  Future<Post> read(PostSingleReadRequest request) {
    if (request.id != null && request.code != null)
      throw new RepositoryInvalidRequestError("Can't read both by id and code");

    if (request.id != null) {
      String url = urlEndpoint + "/" + request.id.toString();
      return delegateRead(urlBase, url, {}, {});
    }

    if (request.code != null) {
      Map<String, String> query = Map();
      query['slug'] = request.code;
      return delegateRead(urlBase, urlEndpoint, query, {});
    }

    throw new RepositoryInvalidRequestError("Should specify id or code");
  }

  @override
  Future<List<Post>> readMany(PostMultiReadRequest request) {
    Map<String, String> query = Map();
    query['categories'] = request.categoryId?.toString() ?? null;
    query['search'] = request.keyWordQuery ?? null;
    query['offset'] = request.readOffset?.toString() ?? null;
    query['per_page'] = request.readCount?.toString() ?? null;
    query['orderby'] = _formatPostOrderBy(request.orderBy) ?? null;
    query['order'] = formatResultOrderType(request.order) ?? null;

    return delegateReadMany(urlBase, urlEndpoint, query, Map<String, String>());
  }
}

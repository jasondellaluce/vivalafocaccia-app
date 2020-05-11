import 'package:app/models/vote.dart';
import '../../core/http_interface.dart';

import '../common.dart';
import '../vote_repository.dart';
import 'abstract_wprest_repository.dart';

class WpRestVoteRepository extends AbstractWpRestRepository<Vote>
    implements VoteRepository {
  final String urlBase;
  final String urlEndpoint = "/wp-json/wp/v2/recipes";
  final String urlEndpointVote = "/wp-json/vlf/v1/recipe-votes";

  WpRestVoteRepository(HttpInterface httpClient, this.urlBase)
      : super(httpClient);

  @override
  Vote parseJsonMap(Map<String, dynamic> map) {
    return Vote(postId: map["post_id"], positiveCount: map["vote_count"]);
  }

  @override
  Future<Vote> create(VoteCreateRequest request) {
    if (request.postId == null || request.isPositive == null)
      throw new RepositoryInvalidRequestError(
          "Should specify both post_id and is_positive");

    return delegateCreate(urlBase, urlEndpointVote, {
      "post_id": request.postId.toString(),
      "is_positive": request.isPositive.toString().toLowerCase()
    }, {});
  }

  @override
  Future<Vote> read(VoteReadRequest request) {
    if (request.postId == null)
      throw new RepositoryInvalidRequestError("Should specify post_id");

    return delegateRead(
        urlBase, urlEndpointVote, {"post_id": request.postId.toString()}, {});
  }
}

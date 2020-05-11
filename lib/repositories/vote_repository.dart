import 'package:app/models/models.dart';

class VoteCreateRequest {
  final int postId;
  final bool isPositive;
  final AuthUser authUser;

  VoteCreateRequest({this.postId, this.isPositive, this.authUser});
}

class VoteReadRequest {
  final int postId;

  VoteReadRequest({this.postId});
}

abstract class VoteRepository {
  /// Retrieves a single element matching the details specified by [request],
  /// if possible. Should return the most updated value retrievable. Errors and
  /// failures regarding retrieval of the element or the configuration of the
  /// request should be caught through the returned [Future] value.
  Future<Vote> read(VoteReadRequest request);

  /// Express a new vote for a specific recipe. Returns the newly updated count
  /// of positive votes for the specified post.
  Future<Vote> create(VoteCreateRequest request);
}

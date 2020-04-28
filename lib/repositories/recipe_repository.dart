
import 'package:app/models/models.dart';
import 'common.dart';

enum RecipeOrderBy {
  date, relevance
}

class RecipeSingleReadRequest {
  final int id;
  final String code;

  RecipeSingleReadRequest({
    this.id,
    this.code
  });
}

class RecipeMultiReadRequest {
  final int readOffset;
  final int readCount;
  final RecipeOrderBy orderBy;
  final ReadOrderType order;
  final int categoryId;
  final String keyWordQuery;

  RecipeMultiReadRequest({
    this.categoryId,
    this.keyWordQuery,
    this.readOffset,
    this.readCount,
    this.orderBy,
    this.order
  });
}


class RecipeVoteReadRequest {
  final int postId;

  RecipeVoteReadRequest({
    this.postId
  });
}

class RecipeVoteCreateRequest {
  final int postId;
  final bool isPositive;
  final AuthUser authUser;

  RecipeVoteCreateRequest({
    this.postId,
    this.isPositive,
    this.authUser});
}

/// Interface that represents a data repository for classes of the legacy.model.
/// It is compliant with the CRUD operations standard. Every result is wrapped
/// in a [Future] object in order to abstract the underlying implementation,
/// that can most likely work with asynchronous operations that mey involve
/// FileSystem, Network communications, and more. Every method can fail
/// and throw error that can be caught with proper handlers in the returned
/// futures.
abstract class RecipeRepository {

  /// Retrieves a single element matching the details specified by [request],
  /// if possible. Should return the most updated value retrievable. Errors and
  /// failures regarding retrieval of the element or the configuration of the
  /// request should be caught through the returned [Future] value.
  Future<Recipe> read(RecipeSingleReadRequest request);

  /// Retrieves a list of elements matching the details specified by [request],
  /// if possible. Should return the most updated values retrievable. Errors and
  /// failures regarding retrieval of the element or the configuration of the
  /// request should be caught through the returned [Future] value.
  Future<List<Recipe>> readMany(RecipeMultiReadRequest request);

}

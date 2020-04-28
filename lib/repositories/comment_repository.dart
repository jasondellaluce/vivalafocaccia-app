
import 'package:app/models/models.dart';
import 'common.dart';

enum CommentOrderBy {
  date
}

class CommentSingleReadRequest {
  final int id;

  CommentSingleReadRequest({
    this.id
  });

}

class CommentCreateRequest {
  final Comment prototype;
  final AuthUser authUser;

  CommentCreateRequest({
    this.prototype,
    this.authUser
  });
}

class CommentMultiReadRequest {
  final int readOffset;
  final int readCount;
  final CommentOrderBy orderBy;
  final ReadOrderType order;

  CommentMultiReadRequest({
    this.readOffset,
    this.readCount,
    this.orderBy,
    this.order
  });
}

/// Interface that represents a data repository for classes of the legacy.model.
/// It is compliant with the CRUD operations standard. Every result is wrapped
/// in a [Future] object in order to abstract the underlying implementation,
/// that can most likely work with asynchronous operations that mey involve
/// FileSystem, Network communications, and more. Every method can fail
/// and throw error that can be caught with proper handlers in the returned
/// futures.
abstract class CommentRepository {

  /// Retrieves a single element matching the details specified by [request],
  /// if possible. Should return the most updated value retrievable. Errors and
  /// failures regarding retrieval of the element or the configuration of the
  /// request should be caught through the returned [Future] value.
  Future<Comment> read(CommentSingleReadRequest request);

  /// Retrieves a list of elements matching the details specified by [request],
  /// if possible. Should return the most updated values retrievable. Errors and
  /// failures regarding retrieval of the element or the configuration of the
  /// request should be caught through the returned [Future] value.
  Future<List<Comment>> readMany(CommentMultiReadRequest request);

  /// Creates and inserts a new element in the repository using the underlying
  /// implementation method. After created, the new element should be
  /// retrievable through [read] and [readMany] methods. [request] represents
  /// a prototype of the element to be created in the repository, containing
  /// the desired data. The returned value should be the element completed with
  /// details assigned after its creation. Errors and failures regarding
  /// retrieval of the element or the configuration of the request should be
  /// caught through the returned [Future] value.
  Future<Comment> create(CommentCreateRequest request);

}
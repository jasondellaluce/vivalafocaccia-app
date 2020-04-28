
import 'package:app/models/models.dart';
import 'common.dart';

enum CategoryOrderBy {
  name
}

class CategorySingleReadRequest {
  final int id;
  final String code;

  CategorySingleReadRequest({
    this.id,
    this.code
  });

}

class CategoryMultiReadRequest {
  final int readOffset;
  final int readCount;
  final CategoryOrderBy orderBy;
  final ReadOrderType order;

  CategoryMultiReadRequest({
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
abstract class CategoryRepository {

  /// Retrieves a single element matching the details specified by [request],
  /// if possible. Should return the most updated value retrievable. Errors and
  /// failures regarding retrieval of the element or the configuration of the
  /// request should be caught through the returned [Future] value.
  Future<Category> read(CategorySingleReadRequest request);

  /// Retrieves a list of elements matching the details specified by [request],
  /// if possible. Should return the most updated values retrievable. Errors and
  /// failures regarding retrieval of the element or the configuration of the
  /// request should be caught through the returned [Future] value.
  Future<List<Category>> readMany(CategoryMultiReadRequest request);

}
import 'package:meta/meta.dart';

class Category {
  final int id;
  final String name;
  final String code;
  final String pageUrl;
  final String featuredImageUrl;

  Category(this.id, this.name, this.code, this.pageUrl, this.featuredImageUrl);
}

enum CategoryOrder { importance }

abstract class CategoryRepository {
  Future<Category> getFromId({@required int id});

  List<Future<Category>> getMany({int offset, int count, CategoryOrder order});
}

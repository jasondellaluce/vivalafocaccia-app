import 'package:app/model/models.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class EmptyState extends SearchState {
  final List<Future<Category>> categoryList;

  EmptyState(this.categoryList);

  @override
  List<Object> get props => [categoryList];
}

class KeywordSelectedState extends SearchState {
  final String text;

  KeywordSelectedState(this.text);

  @override
  List<Object> get props => [text];
}

class CategorySelectedState extends SearchState {
  final Category category;

  CategorySelectedState(this.category);

  @override
  List<Object> get props => [category];
}
import 'package:app/model/models.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class KeywordSelectedEvent extends SearchEvent {
  final String text;

  const KeywordSelectedEvent({this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'KeywordSelectedEvent { text: $text }';
}

class CategorySelectedEvent extends SearchEvent {
  final Category category;

  const CategorySelectedEvent({this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'CategorySelectedEvent { category: ${category.name} }';
}

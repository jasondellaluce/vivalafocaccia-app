import 'package:equatable/equatable.dart';

abstract class RecipeSearchEvent extends Equatable {
  const RecipeSearchEvent();
}

class TextChanged extends RecipeSearchEvent {
  final String text;

  const TextChanged({this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
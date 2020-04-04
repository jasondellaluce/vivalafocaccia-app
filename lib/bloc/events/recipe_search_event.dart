import 'package:app/model/models.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeSearchState extends Equatable {
  const RecipeSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends RecipeSearchState {}

class SearchStateLoading extends RecipeSearchState {}

class SearchStateSuccess extends RecipeSearchState {
  final List<Future<Recipe>> items;

  const SearchStateSuccess(this.items);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchStateError extends RecipeSearchState {
  final String error;

  const SearchStateError(this.error);

  @override
  List<Object> get props => [error];
}
import 'package:app/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

class UninitializedState extends SearchResultState {}

class ResultErrorState extends SearchResultState {
  final String errorStr;

  ResultErrorState(this.errorStr);

  @override
  List<Object> get props => [errorStr];

  @override
  String toString() =>
      'ResultError { error: $errorStr }';
}

class ResultLoadedState extends SearchResultState {
  final int previousLength;
  final List<Future<Recipe>> results;
  final bool hasReachedMax;

  const ResultLoadedState({
    this.results,
    this.previousLength,
    this.hasReachedMax,
  });

  ResultLoadedState copyWith({
    List<Future<Recipe>> results,
    bool hasReachedMax,
  }) {
    return ResultLoadedState(
      results: results ?? this.results,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [results, hasReachedMax];

  @override
  String toString() =>
      'ResultLoaded { results: ${results.length}, previousLength: $previousLength, hasReachedMax: $hasReachedMax }';
}

class RecipeSelectedState extends SearchResultState {
  final Recipe recipe;

  const RecipeSelectedState({
    @required this.recipe
  });

  @override
  List<Object> get props => [recipe];

  @override
  String toString() => 'RecipeSelectedState { recipe: ${recipe.code} }';
}
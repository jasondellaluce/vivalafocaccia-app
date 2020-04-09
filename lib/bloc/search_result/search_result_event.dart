import 'package:app/bloc/search_result/search_result_state.dart';
import 'package:app/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchResultEvent extends SearchResultEvent {}

class RecipeSelectedEvent extends SearchResultEvent {
  final Recipe recipe;
  final SearchResultState currentState;

  RecipeSelectedEvent({
    @required this.recipe,
    @required this.currentState
  });

  @override
  List<Object> get props => [recipe];

  @override
  String toString() => 'RecipeSelectedEvent { recipe: ${recipe.code}, currentState: $currentState}';
}
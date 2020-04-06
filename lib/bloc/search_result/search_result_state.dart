import 'package:app/model/models.dart';
import 'package:equatable/equatable.dart';

abstract class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

class ResultUninitialized extends SearchResultState {}

class GoToPrevPageState extends SearchResultState {}

class ResultError extends SearchResultState {
  final String errorStr;

  ResultError(this.errorStr);

  @override
  List<Object> get props => [errorStr];

  @override
  String toString() =>
      'ResultError { error: $errorStr }';
}

class ResultLoaded extends SearchResultState {
  final int previousLength;
  final List<Future<Recipe>> results;
  final bool hasReachedMax;

  const ResultLoaded({
    this.results,
    this.previousLength,
    this.hasReachedMax,
  });

  ResultLoaded copyWith({
    List<Future<Recipe>> results,
    bool hasReachedMax,
  }) {
    return ResultLoaded(
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
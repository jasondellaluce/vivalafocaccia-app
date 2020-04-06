import 'package:app/model/models.dart';
import 'package:app/model/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'search_result_event.dart';
import 'search_result_state.dart';

abstract class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  final RecipeRepository recipeRepository;
  final int resultsPerRefresh = 10;

  SearchResultBloc(this.recipeRepository);

  @override
  Stream<SearchResultState> transformEvents(
      Stream<SearchResultEvent> events,
      Stream<SearchResultState> Function(SearchResultEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  SearchResultState get initialState => ResultUninitialized();

  @override
  Stream<SearchResultState> mapEventToState(SearchResultEvent event) async* {
    final currentState = state;
    if (event is FetchResult && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ResultUninitialized) {
          final posts = fetchResults(0, resultsPerRefresh);
          yield ResultLoaded(results: posts, hasReachedMax: false);
          return;
        }
        if (currentState is ResultLoaded) {
          final posts = fetchResults(currentState.results.length, resultsPerRefresh);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ResultLoaded(
                  results: currentState.results + posts,
                  previousLength: currentState.results?.length ?? 0,
                  hasReachedMax: false,
              );
        }
      } catch (error) {
        yield ResultError(error.toString());
      }
    }
    if(event is GoToPrevPage) {
      yield GoToPrevPageState();
    }
  }

  bool _hasReachedMax(SearchResultState state) =>
      state is ResultLoaded && state.hasReachedMax;

  List<Future<Recipe>> fetchResults(int startIndex, int limit);
}
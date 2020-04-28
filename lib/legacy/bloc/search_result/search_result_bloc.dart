import 'package:app/legacy/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'search_result_event.dart';
import 'search_result_state.dart';

abstract class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  final RecipeRepository recipeRepository;
  final int resultsPerRefresh = 10;
  SearchResultState lastState = UninitializedState();

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
  SearchResultState get initialState => UninitializedState();

  @override
  Stream<SearchResultState> mapEventToState(SearchResultEvent event) async* {
    final currentState = state;
    if (event is FetchResultEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is UninitializedState) {
          final posts = fetchResults(0, resultsPerRefresh);
          yield ResultLoadedState(results: posts, hasReachedMax: false);
          return;
        }
        if (currentState is ResultLoadedState) {
          final posts = fetchResults(currentState.results.length, resultsPerRefresh);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ResultLoadedState(
                  results: currentState.results + posts,
                  previousLength: currentState.results?.length ?? 0,
                  hasReachedMax: false,
              );
        }
      } catch (error) {
        yield ResultErrorState(error.toString());
      }
    }

    if(event is RecipeSelectedEvent) {
      yield RecipeSelectedState(recipe : event.recipe);
      yield event.currentState;
    }

  }

  bool _hasReachedMax(SearchResultState state) =>
      state is ResultLoadedState && state.hasReachedMax;

  List<Future<Recipe>> fetchResults(int startIndex, int limit);
}
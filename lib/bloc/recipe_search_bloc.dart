import 'package:app/bloc/recipe_search_event.dart';
import 'package:app/bloc/recipe_search_state.dart';
import 'package:app/model/errors.dart';
import 'package:app/model/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class RecipeSearchBloc extends Bloc<RecipeSearchEvent, RecipeSearchState> {
  final RecipeRepository recipeRepository;

  RecipeSearchBloc({@required this.recipeRepository});

  @override
  Stream<RecipeSearchState> transformEvents(
      Stream<RecipeSearchEvent> events,
      Stream<RecipeSearchState> Function(RecipeSearchEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  void onTransition(
      Transition<RecipeSearchEvent, RecipeSearchState> transition) {
    print(transition);
  }

  @override
  RecipeSearchState get initialState => SearchStateEmpty();

  @override
  Stream<RecipeSearchState> mapEventToState(RecipeSearchEvent event) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results = await recipeRepository.getManyFromKeyWords(searchTerm);
          yield SearchStateSuccess(results);
        } catch (error) {
          yield error is ModelRetrieveError
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app/model/models.dart';
import 'package:app/model/repositories.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CategoryRepository categoryRepository;

  SearchBloc({
    @required this.categoryRepository
  });

  @override
  Stream<SearchState> transformEvents(
      Stream<SearchEvent> events,
      Stream<SearchState> Function(SearchEvent event) next,
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
      Transition<SearchEvent, SearchState> transition) {
    print(transition);
  }

  @override
  SearchState get initialState => EmptyState(categoryRepository.getMany());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is KeywordSelectedEvent) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield EmptyState(categoryRepository.getMany());
      } else {
        yield KeywordSelectedState(searchTerm);
      }
    }

    if (event is CategorySelectedEvent) {
      final Category selectedCategory = event.category;
      if (selectedCategory == null) {
        yield EmptyState(categoryRepository.getMany());
      } else {
        yield CategorySelectedState(selectedCategory);
      }
    }
  }
}
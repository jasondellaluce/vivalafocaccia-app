import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app/legacy/model/models.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CategoryRepository categoryRepository;

  SearchBloc({@required this.categoryRepository});

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
        yield EmptyState(categoryRepository.getMany());
      }
    }

    if (event is CategorySelectedEvent) {
      final Category selectedCategory = event.category;
      if (selectedCategory == null) {
        yield EmptyState(categoryRepository.getMany());
      } else {
        yield CategorySelectedState(selectedCategory);
        yield EmptyState(categoryRepository.getMany());
      }
    }
  }
}

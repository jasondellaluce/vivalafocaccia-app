import 'package:app/model/models.dart';
import 'package:meta/meta.dart';
import 'package:app/bloc/search_result/search_result_bloc.dart';

class CategorySearchResultBloc extends SearchResultBloc {
  final Category category;

  CategorySearchResultBloc({
    @required recipeRepository,
    @required this.category
  }) : super(recipeRepository);

  @override
  List<Future<Recipe>> fetchResults(int startIndex, int limit) {
    return recipeRepository.getManyFromCategory(
        category : category,
        offset: startIndex,
        count: limit
    );
  }
}

import 'package:app/legacy/bloc/search_result/search_result_bloc.dart';
import 'package:app/legacy/model/models.dart';
import 'package:flutter/cupertino.dart';

class KeywordSearchResultBloc extends SearchResultBloc {
  String keyWords;

  KeywordSearchResultBloc({
    @required recipeRepository,
    @required this.keyWords
  }) : super(recipeRepository);

  @override
  List<Future<Recipe>> fetchResults(int startIndex, int limit) {
    return recipeRepository.getManyFromKeyWords(
      keyWords : keyWords,
      offset: startIndex,
      count: limit
    );
  }

}
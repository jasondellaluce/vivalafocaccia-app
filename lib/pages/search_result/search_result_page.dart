
import 'package:app/models/models.dart';
import 'package:app/pages/search_result/widgets/fetch_result_widget.dart';
import 'package:app/services/services.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatelessWidget {

  final pagePadding = EdgeInsets.only(top: 0, bottom: 30, left: 20, right: 20);

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: BouncingWidget(
          scaleFactor: -1.5,
          duration: Duration(milliseconds: 100),
          onPressed: () => _onBackButtonPressed(context),
          child: Icon(Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyText1.color)
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    print("Building: SearchResultPage");
    // Obtain navigation arguments
    var args = ModalRoute.of(context).settings.arguments;
    Category categoryQuery;
    String keyWordsQuery;

    // Separate the case of search by category or keywords
    if(args is Category) {
      categoryQuery = args;
    }
    else if(args is String) {
      keyWordsQuery = args;
    }
    else {
      return Scaffold(
        appBar: _buildAppBar(context, "Error"),
        body: Center(
          child: Text("The query is invalid. Should either specify a category or a string."),
        )
      );
    }

    var dataFetchService = Provider.of<DataFetchService>(context, listen: false);
    return Scaffold(
      appBar: _buildAppBar(context, keyWordsQuery == null ? categoryQuery.name : keyWordsQuery),
      body: Padding(
        padding: pagePadding,
        child: FetchResultWidget(
          snippetWidthRatio: 0.75,
          onRecipeTap: _onRecipeSelection,
          onFetchRequest: (offset) {
            if(keyWordsQuery == null) {
              return dataFetchService.getRecipesPerCategory(categoryQuery, offset);
            }
            else {
              return dataFetchService.getRecipesPerKeywords(keyWordsQuery, offset);
            }
          }
        ),
      )
    );
  }

  void _onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRecipeSelection(BuildContext context, Recipe recipe) {
    Provider.of<ContentReadingService>(context, listen: false).selectedRecipe =
        Future.value(recipe);
    Navigator.of(context).pushNamed("/recipeOverview");
  }

}


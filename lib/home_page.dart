import 'package:app/repositories/repositories.dart';
import 'package:app/widgets/recipe_carousel_snippet.dart';
import 'package:app/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'models/models.dart';

class HomePage extends StatelessWidget {
  final topColorHeightRatio = 0.7;
  final recipesPerCategoryCount = 20;

  @override
  Widget build(BuildContext context) {
    // TODO: Inject RepositoryFactory with Provider
    var repositoryFactory = RepositoryFactory();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            // Logo background
            Container(
              height: MediaQuery.of(context).size.height * topColorHeightRatio,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),

            // Real page Contents
            Container(
              child: Column(
                children: <Widget>[
                  // Logo image
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      bottom: 30,
                      left: 25,
                      right: 25,
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Image.asset("assets/logo.png"),
                  ),
                  SizedBox(height: 10),

                  // Search bar
                  Container(
                    margin: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: SearchBarWidget(
                      onSubmit: _onSearchSubmit,
                    ),
                  ),
                  SizedBox(height: 10),

                  FutureBuilder(
                    future: repositoryFactory.forCategory().readMany(
                        CategoryMultiReadRequest(
                            readCount: recipesPerCategoryCount,
                            orderBy: CategoryOrderBy.name)),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      List<Widget> widgetList = [];
                      for (var cat in snapshot.data) {
                        widgetList.add(_CategoryCarouselWidget(
                          category: cat,
                          recipeRepository: repositoryFactory.forRecipe(),
                        ));
                      }
                      return Container(
                        margin: EdgeInsets.only(bottom: 10, left: 25, right: 0),
                        child: Column(
                          children: widgetList,
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSearchSubmit(TextEditingController controller, String searchValue) {
    //TODO: Navigate to keyword search result and erase text in controller
  }
}

class _CategoryCarouselWidget extends StatelessWidget {
  final Category category;
  final RecipeRepository recipeRepository;

  _CategoryCarouselWidget({Key key, this.category, this.recipeRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),

        // Category name and link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            FlatButton(
              onPressed: _onShowMorePressed,
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),

        // Carousel slider
        FutureBuilder(
          future: recipeRepository.readMany(
              RecipeMultiReadRequest(categoryId: category.id, readCount: 10)),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            List<Widget> widgets = [];
            for (var recipe in snapshot.data) {
              widgets.add(RecipeCarouselSnippetWidget(recipe: recipe));
              widgets.add(SizedBox(width: 10));
            }

            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widgets));
          },
        )
      ],
    );
  }

  void _onShowMorePressed() {
    // TODO: Navigate to category search results
  }
}

import 'package:app/models/models.dart';
import 'package:app/widgets/widgets.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/category_carousel.dart';

class HomePage extends StatelessWidget {
  final topColorHeightRatio = 0.7;
  final recipesPerCategoryCount = 20;
  final logoImageWidthRatio = 0.55;

  @override
  Widget build(BuildContext context) {
    print("Building: HomePage");
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
                    width:
                        MediaQuery.of(context).size.width * logoImageWidthRatio,
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
                    future:
                        Provider.of<BlogContentService>(context, listen: false)
                            .getCategories(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      List<Widget> widgetList = [];
                      for (var category in snapshot.data) {
                        widgetList.add(CategoryCarouselWidget(
                          category: category,
                          onShowMoreTap: _onCategoryShowMore,
                          onRecipeTap: _onRecipeSnippetTap,
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

  void _onSearchSubmit(BuildContext context, TextEditingController controller,
      String searchValue) {
    //TODO: Navigate to keyword search result and erase text in controller
  }

  void _onCategoryShowMore(BuildContext context, Category category) {
    //TODO: Navigate to category search result and erase text in controller
  }

  void _onRecipeSnippetTap(BuildContext context, Recipe recipe) {
    Provider.of<ContentReadingService>(context, listen: false).selectedRecipe =
        Future.value(recipe);
    Navigator.of(context).pushNamed("/recipeOverview");
  }
}

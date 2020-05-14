import 'widgets/recipe_description.dart';
import 'widgets/recipe_ingredients.dart';
import 'package:flutter/material.dart';

class RecipeOverviewPage extends StatelessWidget {
  final sharedPadding = EdgeInsets.all(20.0);
  @override
  Widget build(BuildContext context) {
    print("Building: RecipeOverviewPage");
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          // TODO: Do other widgets
          RecipeIngredientsWidget(padding: sharedPadding),
          RecipeDescriptionWidget(padding: sharedPadding),
        ],
      ),
    ));
  }
}

import 'package:app/models/recipe.dart';
import 'package:app/services/content_reading_service.dart';
import 'package:app/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsWidget extends StatelessWidget {
  final EdgeInsets padding;
  final String stringReplaceValue = "[VALUE]";

  const RecipeDetailsWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentReadingService>(
      builder: (context, service, child) {
        return FutureBuilder(
          future: service.selectedRecipe,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            Recipe recipe = snapshot.data;
            var localization =
                Provider.of<LocalizationService>(context, listen: false);
            if (recipe.servesCount == 0 &&
                recipe.cookingTime?.length == 0 &&
                recipe.cookingTemperature?.length == 0 &&
                recipe.difficulty?.length == 0) return Container();
            return Container(
              padding: padding,
              child: Wrap(
                children: <Widget>[
                  _RecipeSingleDetailWidget(
                    text: localization["recipePageServingCount"],
                    value: recipe.servesCount.toString(),
                    icon: Icon(Icons.people),
                    valueTextReplace: stringReplaceValue,
                  ),
                  _RecipeSingleDetailWidget(
                    text: localization["recipePageCookingTime"],
                    value: recipe.cookingTime.toString(),
                    icon: Icon(Icons.av_timer),
                    valueTextReplace: stringReplaceValue,
                  ),
                  _RecipeSingleDetailWidget(
                    text: localization["recipePageCookingTemperature"],
                    value: recipe.cookingTemperature.toString(),
                    icon: Icon(Icons.wb_sunny),
                    valueTextReplace: stringReplaceValue,
                  ),
                  _RecipeSingleDetailWidget(
                    text: localization["recipePageDifficulty"],
                    value: recipe.ratingsCount.toString(),
                    icon: Icon(Icons.fastfood),
                    valueTextReplace: stringReplaceValue,
                    isLast: true,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _RecipeSingleDetailWidget extends StatelessWidget {
  final String value;
  final String text;
  final String valueTextReplace;
  final Icon icon;
  final bool isLast;

  const _RecipeSingleDetailWidget(
      {Key key,
      this.value,
      this.text,
      this.valueTextReplace,
      this.icon,
      this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return text?.length == 0
        ? Container()
        : Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  icon,
                  SizedBox(width: 10),
                  Text(text.replaceFirst(valueTextReplace, value))
                ],
              ),
              !isLast ? SizedBox(height: 10) : Container()
            ],
          );
  }
}

import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/widgets/basic_button.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeUserPanelWidget extends StatelessWidget {
  final String replaceTextValue = "[VALUE]";
  final EdgeInsets padding;
  final Function(BuildContext, Recipe) onVoteTap;
  final Function(BuildContext, Recipe) onReviewTap;

  const RecipeUserPanelWidget(
      {Key key, this.padding, this.onVoteTap, this.onReviewTap})
      : super(key: key);

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
            return Container(
              width: double.infinity,
              padding: padding,
              child: Column(
                children: <Widget>[
                  /// likes, review, comments
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /// Likes
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            BasicButton(
                              onTap: () => onVoteTap(context, recipe),
                              padding: EdgeInsets.all(0),
                              child: Icon(CupertinoIcons.heart,
                                  color: Colors.red, size: 25.0),
                              color: Colors.transparent,
                              hasShadow: false,
                              animationScale: -2,
                            ),
                            Container(height: 5),
                            Text(
                              localization["recipePageVoteCountIcon"]
                                  .replaceFirst(replaceTextValue,
                                      recipe.votesCount.toString()),
                            ),
                          ],
                        ),

                        /// Share
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            BouncingWidget(
                              onPressed: () => onReviewTap(context, recipe),
                              scaleFactor: -2,
                              duration: Duration(milliseconds: 100),
                              child: Row(
                                  children: List.generate(5, (index) {
                                if (index < (recipe.averageRating?.ceil() ?? 0))
                                  return Icon(Icons.star,
                                      color: Theme.of(context).accentColor);
                                return Icon(Icons.star_border,
                                    color: Theme.of(context).accentColor);
                              })),
                            ),
                            Container(height: 5),
                            Text(
                              recipe.ratingsCount == 0
                                  ? localization["recipePageAskForReviewIcon"]
                                  : localization["recipePageReviewCountIcon"]
                                      .replaceFirst(replaceTextValue,
                                          recipe.ratingsCount.toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
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

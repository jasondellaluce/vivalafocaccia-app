import 'package:flutter/material.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:app/models/recipe.dart';
import 'package:app/services/content_reading_service.dart';
import 'package:app/services/localization_service.dart';

import 'widgets/recipe_details.dart';
import 'widgets/recipe_header.dart';
import 'widgets/recipe_rich_description.dart';
import 'widgets/recipe_step_list.dart';
import 'widgets/recipe_user_panel.dart';
import 'widgets/recipe_description.dart';
import 'widgets/recipe_ingredients.dart';

class RecipeOverviewPage extends StatelessWidget {
  final sharedPadding = EdgeInsets.all(20.0);

  AppBar _buildAppBar(BuildContext context) {
    var localization = Provider.of<LocalizationService>(context, listen: false);
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: BouncingWidget(
          scaleFactor: -1.5,
          duration: Duration(milliseconds: 100),
          onPressed: () => _onBackButtonPressed(context),
          child: Icon(Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyText1.color)),
      actions: <Widget>[
        BouncingWidget(
            scaleFactor: -1.5,
            duration: Duration(milliseconds: 100),
            onPressed: () => _onCommentButtonPressed(context),
            child: Icon(Icons.insert_comment,
                color: Theme.of(context).textTheme.bodyText1.color)),
        SizedBox(width: 20),
        Consumer<ContentReadingService>(builder: (context, service, child) {
          return FutureBuilder(
            future: service.selectedRecipe,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return BouncingWidget(
                  scaleFactor: -1.5,
                  duration: Duration(milliseconds: 100),
                  onPressed: () => _onShareButtonPressed(context, snapshot.data,
                      localization["recipeShareSubjectLabel"]),
                  child: Icon(Icons.share,
                      color: Theme.of(context).textTheme.bodyText1.color));
            },
          );
        }),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building: RecipeOverviewPage");
    return Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              RecipeHeaderWidget(padding: sharedPadding),
              RecipeUserPanelWidget(
                padding: sharedPadding,
                onVoteTap: _onVoteButtonPressed,
                onReviewTap: _onReviewButtonPressed,
              ),
              RecipeDetailsWidget(padding: sharedPadding),
              RecipeDescriptionWidget(padding: sharedPadding),
              RecipeIngredientsWidget(padding: sharedPadding),
              RecipeRichDescriptionWidget(
                  padding: sharedPadding, onUrlLinkTap: _onUrlLinkTap),
              RecipeStepListWidget(padding: sharedPadding)
            ],
          ),
        ));
  }

  void _onBackButtonPressed(BuildContext context) {
    // TODO: Navigateto previous page or close app
  }

  void _onCommentButtonPressed(BuildContext context) {
    // TODO: Navigate to comment list page
  }

  void _onShareButtonPressed(
      BuildContext context, Recipe recipe, String subject) {
    Share.share(
        parse(recipe.title).documentElement.text.trim() + "\n" + recipe.pageUrl,
        subject: subject);
  }

  void _onUrlLinkTap(BuildContext context, String url) {
    // TODO: Open link in app or browser
  }

  void _onVoteButtonPressed(BuildContext context, Recipe recipe) {
    // TODO: Send user vote
  }

  void _onReviewButtonPressed(BuildContext context, Recipe recipe) {
    // TODO: Open a dialog and let user write his review
  }
}

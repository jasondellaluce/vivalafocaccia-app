import 'package:app/models/models.dart';
import 'package:app/pages/recipe_overview/widgets/recipe_loading.dart';
import 'package:app/pages/recipe_overview/widgets/recipe_loading_error.dart';
import 'package:app/services/content_reading_service.dart';
import 'package:app/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class RecipeHeaderWidget extends StatelessWidget {
  final double imageHeightRatio;
  final EdgeInsets padding;

  const RecipeHeaderWidget(
      {Key key, this.imageHeightRatio = 0.45, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Video stuff here
    return Consumer<ContentReadingService>(
      builder: (context, service, child) {
        return FutureBuilder(
          future: service.selectedRecipe,
          builder: (context, snapshot) {
            if (!snapshot.hasError && !snapshot.hasData)
              return RecipeLoadingWidget();
            if (snapshot.hasError)
              return RecipeLoadingErrorWidget(error: snapshot.error);

            Recipe recipe = snapshot.data;
            return Container(
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height *
                            imageHeightRatio,
                        child: CachedNetworkImage(
                          imageUrl: recipe.featuredImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: padding.copyWith(bottom: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Center(
                          child: Text(
                            parse(recipe.title).documentElement.text,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height *
                            imageHeightRatio /
                            2 -
                        25,
                    left: MediaQuery.of(context).size.width / 2 - 25,
                    child: BasicButton(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(100),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.play_arrow, size: 30),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

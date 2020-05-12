import 'package:app/models/models.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class RecipeCarouselSnippetWidget extends StatelessWidget {

  final Recipe recipe;
  final width;
  final borderRadius = BorderRadius.circular(10);
  final Function() onTap;

  RecipeCarouselSnippetWidget({
    Key key,
    this.recipe,
    this.width = (375 - 60) / 2,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            // Recipe picture
            Card(
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              elevation: 6.0,
              child: Container(
                width: width,
                height: width,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                ),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: recipe.featuredImageUrl,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2),

            // Recipe name
            Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                parse(recipe.title).documentElement.text.trim(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}

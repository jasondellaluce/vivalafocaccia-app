import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recipe_carousel_snippet.dart';
import 'category_title_and_button.dart';
import 'category_progress_indicator.dart';

class CategoryCarouselWidget extends StatelessWidget {
  final Category category;
  final Function(BuildContext, Category) onShowMoreTap;
  final Function(BuildContext, Recipe) onRecipeTap;
  final categoryTitleWidthProportion;

  const CategoryCarouselWidget(
      {Key key,
      this.category,
      this.onShowMoreTap,
      this.onRecipeTap,
      this.categoryTitleWidthProportion = 0.6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),

        // Category name and link
        CategoryTitleAndButtonWidget(
            categoryTitleWidthProportion: categoryTitleWidthProportion,
            category: category,
            onTap: onShowMoreTap),

        // Carousel slider
        FutureBuilder(
          future: Provider.of<BlogContentService>(context, listen: false)
              .getRecipesPerCategory(category, 0),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CategoryProgressIndicator();

            List<Widget> widgets = [];
            for (var recipe in snapshot.data) {
              widgets.add(RecipeCarouselSnippetWidget(
                recipe: recipe,
                onTap: () => onRecipeTap(context, recipe),
              ));
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
}

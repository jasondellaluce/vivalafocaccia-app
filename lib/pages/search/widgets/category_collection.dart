
import 'category_snippet.dart';
import 'package:app/models/models.dart';
import 'package:flutter/material.dart';

class CategoryCollectionWidget extends StatelessWidget {

  final double snippetWidth;
  final double spacing;
  final Future<List<Category>> categoryListFuture;
  final Function(BuildContext, Category) onCategorySelection;

  const CategoryCollectionWidget({Key key, this.categoryListFuture, this.snippetWidth, this.spacing, this.onCategorySelection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoryListFuture,
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        List<Category> result = snapshot.data;
        List<Widget> widgets = result.map((c) => CategorySnippetWidget(category: c, onTap: onCategorySelection, width: snippetWidth,)).toList();
        return Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          spacing: spacing,
          runSpacing: spacing,
          children: widgets,
        );
      },
    );
  }

}
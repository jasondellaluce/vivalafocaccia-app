import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class RecipeDescriptionWidget extends StatelessWidget {
  final EdgeInsets padding;

  const RecipeDescriptionWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentReadingService>(
      builder: (context, service, child) {
        return FutureBuilder(
          future: service.selectedRecipe,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            Recipe value = snapshot.data;
            if (value.description == null || value.description.length == 0)
              return Container();
            return Container(
              padding: padding,
              child: Text(
                parse(value.description).documentElement.text.trim(),
                style: TextStyle(height: 1.5),
              ),
            );
          },
        );
      },
    );
  }
}

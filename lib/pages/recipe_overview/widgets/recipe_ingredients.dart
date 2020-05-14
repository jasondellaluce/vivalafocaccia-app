import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class RecipeIngredientsWidget extends StatelessWidget {
  final EdgeInsets padding;

  const RecipeIngredientsWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = Provider.of<LocalizationService>(context, listen: false);
    return Consumer<ContentReadingService>(
      builder: (context, service, child) {
        return FutureBuilder(
          future: service.selectedRecipe,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            Recipe value = snapshot.data;
            if (value.ingredientList.length == 0) return Container();

            return Container(
              width: double.infinity,
              padding: padding,
              color: Theme.of(context).primaryColor,
              child: Wrap(
                runSpacing: 10,
                children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.assignment),
                          SizedBox(width: 8),
                          Text(localization["recipePageIngredientsTitle"],
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )
                    ] +
                    value.ingredientList.map((ingredient) {
                      if (ingredient.isTitle)
                        return _SingleIngredient(
                            name: ingredient.name, showAsLabel: true);
                      return _SingleIngredient(
                          name: ingredient.quantity.toString() +
                              " " +
                              ingredient.name,
                          showAsLabel: false);
                    }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}

class _SingleIngredient extends StatefulWidget {
  final bool showAsLabel;
  final String name;

  const _SingleIngredient({Key key, this.showAsLabel = false, this.name})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleIngredientState();
}

class _SingleIngredientState extends State<_SingleIngredient> {
  bool selected;

  @override
  void initState() {
    selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showAsLabel) {
      return Text(
        widget.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }
    return Container(
        child: GestureDetector(
      onTap: () => setState(() {
        selected = !selected;
      }),
      child: Row(
        children: <Widget>[
          selected
              ? Icon(Icons.check_circle)
              : Icon(Icons.radio_button_unchecked),
          SizedBox(width: 10),
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(parse(widget.name).documentElement.text.trim(),
                  maxLines: 2, overflow: TextOverflow.fade))
        ],
      ),
    ));
  }
}

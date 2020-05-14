import 'package:app/models/models.dart';
import 'package:flutter/material.dart';

class CategoryTitleAndButtonWidget extends StatelessWidget {
  final categoryTitleWidthProportion;
  final Category category;
  final Function(BuildContext, Category) onTap;

  const CategoryTitleAndButtonWidget({
    Key key,
    @required this.categoryTitleWidthProportion,
    @required this.category,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width:
              MediaQuery.of(context).size.width * categoryTitleWidthProportion,
          child: Text(
            category.name,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        FlatButton(
          onPressed: () => onTap(context, category),
          child: Icon(Icons.arrow_forward),
        )
      ],
    );
  }
}

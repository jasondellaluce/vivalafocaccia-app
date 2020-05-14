import 'package:app/models/models.dart';
import 'package:app/services/content_reading_service.dart';
import 'package:app/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class RecipeRichDescriptionWidget extends StatefulWidget {
  final EdgeInsets padding;
  final Function(BuildContext, String) onUrlLinkTap;

  const RecipeRichDescriptionWidget({Key key, this.padding, this.onUrlLinkTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RecipeRichDescriptionWidgetState();
}

class RecipeRichDescriptionWidgetState
    extends State<RecipeRichDescriptionWidget> {
  bool expanded;

  @override
  void initState() {
    expanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localization = Provider.of<LocalizationService>(context, listen: false);
    return Consumer<ContentReadingService>(
      builder: (context, service, child) {
        return FutureBuilder(
            future: service.selectedRecipe,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              Recipe recipe = snapshot.data;
              return Container(
                padding: widget.padding,
                child: Column(
                  children: <Widget>[
                    // Header title
                    Row(
                      children: <Widget>[
                        Icon(Icons.format_indent_increase),
                        SizedBox(width: 8),
                        Text(localization["recipePageDescriptionTitle"],
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Html(
                        data: expanded
                            ? recipe.content
                            : recipe.content.substring(0, 250) + "...",
                        onLinkTap: (s) => widget.onUrlLinkTap(context, s),
                        defaultTextStyle: TextStyle(height: 1.5),
                        linkStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Theme.of(context).accentColor),
                        useRichText: true,
                      ),
                    ),

                    FlatButton(
                        child: Text(
                          expanded
                              ? localization["readLessLabel"]
                              : localization["readMoreLabel"],
                          textAlign: TextAlign.right,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () => setState(() => expanded = !expanded))
                  ],
                ),
              );
            });
      },
    );
  }
}

import 'package:app/models/models.dart';
import 'package:app/services/content_reading_service.dart';
import 'package:app/services/localization_service.dart';
import 'package:app/widgets/widgets.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class RecipeStepListWidget extends StatelessWidget {
  final EdgeInsets padding;

  const RecipeStepListWidget({Key key, this.padding}) : super(key: key);

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
              padding: padding,
              child: Column(
                  children: <Widget>[
                        BasicButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          child: Text(
                            localization["recipePageStepByStepLabel"],
                            style: TextStyle(
                                color:
                                    Theme.of(context).primaryIconTheme.color),
                          ),
                        ),
                        SizedBox(height: 20)
                      ] +
                      List.generate(recipe.stepList.length, (index) {
                        return _RecipeSingleStepWidget(
                            stepList: recipe.stepList, stepIndex: index);
                      })),
            );
          },
        );
      },
    );
  }
}

class _RecipeSingleStepWidget extends StatefulWidget {
  final List<RecipeStep> stepList;
  final int stepIndex;

  const _RecipeSingleStepWidget({Key key, this.stepList, this.stepIndex})
      : super(key: key);

  @override
  _RecipeSingleStepWidgetState createState() => _RecipeSingleStepWidgetState();
}

class _RecipeSingleStepWidgetState extends State<_RecipeSingleStepWidget> {
  bool selected;
  int selectedImageIndex;

  @override
  void initState() {
    selected = false;
    selectedImageIndex = 0;
    super.initState();
  }

  void toggleCheckBox() {
    selected = !selected;
  }

  void toggleImageSelection() {
    selectedImageIndex = (selectedImageIndex + 1) %
        widget.stepList[widget.stepIndex].featuredImageUrlList.length;
  }

  @override
  Widget build(BuildContext context) {
    var step = widget.stepList[widget.stepIndex];
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // Index and check icon
            Column(
              children: <Widget>[
                Text((widget.stepIndex + 1).toString()),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => setState(toggleCheckBox),
                  child: Icon(selected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                )
              ],
            ),

            SizedBox(width: 20),

            Column(
              children: <Widget>[
                SizedBox(height: 20),
                // Title
                (step.title?.length == 0
                    ? Container()
                    : Column(
                        children: <Widget>[
                          Text(
                            parse(step.title).documentElement.text.trim(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      )),

                // Selected image
                (step.featuredImageUrlList.length == 0
                    ? Container()
                    : BouncingWidget(
                        onPressed: () => setState(toggleImageSelection),
                        scaleFactor: -2,
                        duration: Duration(milliseconds: 100),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    child: CachedNetworkImage(
                                  imageUrl: step
                                      .featuredImageUrlList[selectedImageIndex],
                                )),
                                step.featuredImageUrlList.length < 2
                                    ? Container()
                                    : Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: Icon(Icons.layers,
                                            color: Theme.of(context)
                                                .primaryIconTheme
                                                .color,
                                            size: 25),
                                      )
                              ],
                            ),
                          ),
                        ),
                      )),

                SizedBox(height: 15),

                // Description
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Html(
                    data: parse(step.description).documentElement.text.trim(),
                    defaultTextStyle: TextStyle(
                      height: 1.5,
                    ),
                    showImages: step.featuredImageUrlList.length == 0,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        Divider(thickness: 2)
      ],
    );
  }
}

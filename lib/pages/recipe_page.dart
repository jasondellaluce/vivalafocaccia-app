import 'package:app/models/models.dart';
import 'package:app/widgets/basic_button.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

import 'package:app/core/core.dart';
import 'package:share/share.dart';

class RecipePage extends StatelessWidget {
  final defaultPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 25);

  @override
  Widget build(BuildContext context) {
    // TODO: Extract useful widgets in other modules
    // TODO: Integrate video
    // TODO: Manage colors better
    Future<Recipe> futureRecipe = Future.value(Recipe());
    if(ModalRoute.of(context).settings.arguments is Recipe) {
      futureRecipe = Future.value(ModalRoute.of(context).settings.arguments);
    }
    else if(ModalRoute.of(context).settings.arguments is Future<Recipe>) {
      futureRecipe = ModalRoute.of(context).settings.arguments;
    }
    return FutureBuilder(
      future: futureRecipe,
      builder: (futureContext, snapshot) {
        if (snapshot.hasError)
          return _LoadingErrorWidget(errorLabel: snapshot.error.toString());

        if (!snapshot.hasData)
          return _LoadingWidget();

        return Provider<Recipe>(
            create: (context) => snapshot.data,
            child: _MainPageWidget(defaultPadding: defaultPadding));
      },
    );
  }

}

class _MainPageWidget extends StatelessWidget {

  const _MainPageWidget({
    Key key,
    @required this.defaultPadding,
  }) : super(key: key);

  final EdgeInsets defaultPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                onPressed: _onCommentButtonPressed,
                child: Icon(Icons.insert_comment,
                    color:
                        Theme.of(context).textTheme.bodyText1.color)),
            SizedBox(width: 20),
            BouncingWidget(
                scaleFactor: -1.5,
                duration: Duration(milliseconds: 100),
                onPressed: () => _onShareButtonPressed(context, context.read<Recipe>(), context.read<Localization>()["recipeShareSubjectLabel"]),
                child: Icon(Icons.share,
                    color:
                        Theme.of(context).textTheme.bodyText1.color)),
            SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              child: Column(
            children: <Widget>[
              _HeaderImageWidget(),
              _HeaderDetailsWidget(padding: defaultPadding),
              _RecipeDetailsListWidget(padding: defaultPadding),
              _RecipeDescriptionWidget(padding: defaultPadding),
              _IngredientDetailsWidget(padding: defaultPadding),
              _DescriptionWidget(padding: defaultPadding),
              // _RecipeTimingPreviewWidget(padding: defaultPadding),
              _StepListWidget(padding: defaultPadding)
            ],
          )),
        ));
  }

  void _onBackButtonPressed(context) {
    if(!Navigator.canPop(context))
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    else
      Navigator.pop(context);
  }

  void _onCommentButtonPressed() {
    // TODO: Navigate to comment list page
  }

  void _onShareButtonPressed(BuildContext context, Recipe recipe, String subject) {
    Share.share(parse(recipe.title).documentElement.text.trim() + "\n" + recipe.pageUrl, subject: subject);
  }

}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Cooler loading animation
    return Scaffold(
      body: CircularProgressIndicator()
    );
  }
}

class _LoadingErrorWidget extends StatelessWidget {
  final String errorLabel;

  const _LoadingErrorWidget({Key key, this.errorLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Cooler error printing
    return Scaffold(
      body: Text(errorLabel)
    );
  }
}


class _HeaderImageWidget extends StatelessWidget {
  final imageHeightRatio = 0.45;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * imageHeightRatio,
                child: CachedNetworkImage(
                  imageUrl: context.watch<Recipe>().featuredImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Center(
                  child: Text(
                    parse(context.watch<Recipe>().title).documentElement.text,
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
            top: MediaQuery.of(context).size.height * imageHeightRatio / 2 - 25,
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
  }
}

class _HeaderDetailsWidget extends StatelessWidget {
  final EdgeInsets padding;

  const _HeaderDetailsWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recipe = context.watch<Recipe>();
    return Container(
      width: double.infinity,
      padding: padding,
      child: Column(
        children: <Widget>[
          /// likes, review, comments
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// Likes
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BasicButton(
                      onTap: _onVoteButtonPressed,
                      padding: EdgeInsets.all(0),
                      child: Icon(CupertinoIcons.heart,
                          color: Colors.red, size: 25.0),
                      color: Colors.transparent,
                      hasShadow: false,
                      animationScale: -2,
                    ),
                    Container(height: 5),
                    Text(
                      context
                          .watch<Localization>()["recipePageVoteCountIcon"]
                          .replaceFirst("COUNT", recipe.votesCount.toString()),
                    ),
                  ],
                ),

                /// Share
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BouncingWidget(
                      onPressed: _onReviewButtonPressed,
                      scaleFactor: -2,
                      duration: Duration(milliseconds: 100),
                      child: Row(
                          children: List.generate(5, (index) {
                        if (recipe.averageRating != null && index < recipe.averageRating.ceil())
                          return Icon(Icons.star,
                              color: Theme.of(context).accentColor);
                        return Icon(Icons.star_border,
                            color: Theme.of(context).accentColor);
                      })),
                    ),
                    Container(height: 5),
                    Text(
                      recipe.ratingsCount == 0
                          ? context.watch<Localization>()[
                              "recipePageAskForReviewIcon"]
                          : context
                              .watch<Localization>()[
                                  "recipePageReviewCountIcon"]
                              .replaceFirst(
                                  "COUNT", recipe.ratingsCount.toString()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onVoteButtonPressed() {
    // TODO: Ask for authentication or execute vote with VoteRepository, also update count
  }

  void _onReviewButtonPressed() {
    // TODO: Open review list page
  }
}

class _RecipeDescriptionWidget extends StatelessWidget {
  final EdgeInsets padding;

  const _RecipeDescriptionWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<Recipe>().description == null ||
        context.watch<Recipe>().description.length == 0) return Container();
    return Container(
      padding: padding,
      child: Text(
        parse(context.watch<Recipe>().description).documentElement.text.trim(),
        style: TextStyle(height: 1.5),
      ),
    );
  }
}

class _RecipeDetailsListWidget extends StatelessWidget {
  final EdgeInsets padding;

  const _RecipeDetailsListWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recipe = context.watch<Recipe>();
    if (context.watch<Recipe>().servesCount == 0 &&
        context.watch<Recipe>().cookingTime?.length == 0 &&
        context.watch<Recipe>().cookingTemperature?.length == 0 &&
        context.watch<Recipe>().difficulty?.length == 0) return Container();
    return Container(
      padding: padding,
      child: Wrap(
        children: <Widget>[
          /// Serves count
          context.watch<Recipe>().servesCount == 0
              ? Container()
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.people),
                        SizedBox(width: 10),
                        Text(context
                            .watch<Localization>()["recipePageServingCount"]
                            .replaceFirst(
                                "COUNT", recipe.ratingsCount.toString()))
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),

          /// Cooking time
          context.watch<Recipe>().cookingTime.length == 0
              ? Container()
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.av_timer),
                        SizedBox(width: 10),
                        Text(context
                            .watch<Localization>()["recipePageCookingTime"]
                            .replaceFirst(
                                "VALUE", recipe.ratingsCount.toString()))
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),

          /// Cooking temperature
          context.watch<Recipe>().cookingTemperature.length == 0
              ? Container()
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.wb_sunny),
                        SizedBox(width: 10),
                        Text(context
                            .watch<Localization>()[
                                "recipePageCookingTemperature"]
                            .replaceFirst(
                                "VALUE", recipe.ratingsCount.toString()))
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),

          /// Difficulty
          context.watch<Recipe>().difficulty.length == 0
              ? Container()
              : Row(
                  children: <Widget>[
                    Icon(Icons.fastfood),
                    SizedBox(width: 10),
                    Text(context
                        .watch<Localization>()["recipePageDifficulty"]
                        .replaceFirst("VALUE", recipe.ratingsCount.toString()))
                  ],
                ),
        ],
      ),
    );
  }
}

class _IngredientDetailsWidget extends StatelessWidget {
  final EdgeInsets padding;

  const _IngredientDetailsWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Recipe recipe = context.watch<Recipe>();
    if (recipe.ingredientList.length == 0) return Container();
    return

        /// Ingredients
        Container(
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
                  Text(
                      context
                          .watch<Localization>()["recipePageIngredientsTitle"],
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              )
            ] +
            recipe.ingredientList.map((ingredient) {
              if (ingredient.isTitle)
                return _SingleIngredient(
                    name: ingredient.name, showAsLabel: true);
              return _SingleIngredient(
                  name: ingredient.quantity.toString() + " " + ingredient.name,
                  showAsLabel: false);
            }).toList(),
      ),
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
              child: Text(
                parse(widget.name).documentElement.text.trim(),
                maxLines: 2,
                overflow: TextOverflow.fade
              )
            )
          ],
        ),
      )
    );
  }
}

class _DescriptionWidget extends StatefulWidget {
  final EdgeInsets padding;

  const _DescriptionWidget({Key key, this.padding}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<_DescriptionWidget> {
  bool expanded;

  @override
  void initState() {
    expanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Recipe recipe = context.watch<Recipe>();
    return Container(
      padding: widget.padding,
      child: Column(
        children: <Widget>[
          // Header title
          Row(
            children: <Widget>[
              Icon(Icons.format_indent_increase),
              SizedBox(width: 8),
              Text(context.watch<Localization>()["recipePageDescriptionTitle"],
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 10),
          Container(
            child: Html(
              data: expanded
                  ? recipe.content
                  : recipe.content.substring(0, 250) + "...",
              onLinkTap: _onUrlLinkPressed,
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
                    ? context.watch<Localization>()["readLessLabel"]
                    : context.watch<Localization>()["readMoreLabel"],
                textAlign: TextAlign.right,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () => setState(() => expanded = !expanded))
        ],
      ),
    );
  }

  void _onUrlLinkPressed(String url) {}
}

class _StepListWidget extends StatelessWidget {
  final EdgeInsets padding;

  const _StepListWidget({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
          children: <Widget>[
                BasicButton(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Text(
                    context.watch<Localization>()["recipePageStepByStepLabel"],
                    style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color),
                  ),
                ),
                SizedBox(height: 20)
              ] +
              List.generate(context.watch<Recipe>().stepList.length, (index) {
                return _SingleStepWidget(index: index);
              })),
    );
  }
}

class _SingleStepWidget extends StatefulWidget {
  final int index;

  _SingleStepWidget({Key key, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleStepWidgetState();
}

class _SingleStepWidgetState extends State<_SingleStepWidget> {
  bool selected;
  int selectedImageIndex;

  @override
  void initState() {
    selected = false;
    selectedImageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var stepList = context.watch<Recipe>().stepList;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // Index and check icon
            Column(
              children: <Widget>[
                Text((widget.index + 1).toString()),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => setState(() => selected = !selected),
                  child: Icon(selected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                )
              ],
            ),

            SizedBox(width: 20),
            // Image and description
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                stepList[widget.index].title?.length == 0
                    ? Container()
                    : Column(
                        children: <Widget>[
                          Text(
                            parse(stepList[widget.index].title).documentElement.text.trim(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                (stepList[widget.index].featuredImageUrlList.length == 0
                    ? Container()
                    : BouncingWidget(
                        onPressed: () => setState(() {
                          selectedImageIndex = (selectedImageIndex + 1) %
                              stepList[widget.index]
                                  .featuredImageUrlList
                                  .length;
                        }),
                        scaleFactor: -2,
                        duration: Duration(milliseconds: 100),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    child: Image.network(stepList[widget.index]
                                            .featuredImageUrlList[
                                        selectedImageIndex])),
                                stepList[widget.index].featuredImageUrlList.length < 2
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Html(
                    data: parse(stepList[widget.index].description).documentElement.text.trim(),
                    defaultTextStyle: TextStyle(
                      height: 1.5,
                    ),
                    showImages:
                        stepList[widget.index].featuredImageUrlList.length == 0,
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

class _RecipeTimingPreviewWidget extends StatefulWidget {
  final EdgeInsets padding;

  const _RecipeTimingPreviewWidget({Key key, this.padding}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipeTimingPreviewState();
}

class _RecipeTimingPreviewState extends State<_RecipeTimingPreviewWidget> {
  TimeOfDay startDateTime;

  @override
  void initState() {
    startDateTime = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implement this completely and use timepicker
    // ToDO: Export external widget
    return Container(
        padding: widget.padding,
        color: Theme.of(context).primaryColor,
        child: Wrap(
          runSpacing: 10,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.av_timer),
                SizedBox(width: 8),
                Text(
                    context
                        .watch<Localization>()["recipeTimingCalculatorTitle"],
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    context.watch<Localization>()[
                        "recipeTimingCalculatorStartByLabel"],
                  ],
                )
              ],
            )
          ],
        ));
  }
}

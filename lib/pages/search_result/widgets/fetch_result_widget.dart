import 'package:flutter/material.dart';
import 'package:app/models/models.dart';

import '../../home/widgets/recipe_carousel_snippet.dart';
import 'progress_indicator.dart';

class FetchResultWidget extends StatefulWidget {
  final double snippetWidthRatio;
  final Function(BuildContext, Recipe) onRecipeTap;
  final Future<List<Recipe>> Function(int) onFetchRequest;

  const FetchResultWidget({Key key, this.onFetchRequest, this.onRecipeTap, this.snippetWidthRatio}) : super(key: key);

  @override
  FetchResultWidgetState createState() => FetchResultWidgetState();
}

class FetchResultWidgetState extends State<FetchResultWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 20.0;
  List<Recipe> resultList;
  bool hasReachedMax;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if(!hasReachedMax)
        _fetchNewData();
    }
  }

  void _fetchNewData() {
    widget.onFetchRequest(resultList.length).then((newResults) {
      setState((){
        if(newResults.length == 0) {
          hasReachedMax = true;
        }
        else {
          resultList = resultList + newResults;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    resultList = [];
    hasReachedMax = false;
    _fetchNewData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: hasReachedMax ? resultList.length : (resultList.length + 1),
      controller: _scrollController,
      itemBuilder: (context, index) {
        if(index >= resultList.length) {
          return ProgressIndicatorWidget();
        }
        else {
          return Padding(
            padding: EdgeInsets.only(top: 20),
            child: RecipeCarouselSnippetWidget(
              recipe: resultList[index],
              onTap: () => widget.onRecipeTap(context, resultList[index]),
              width: MediaQuery.of(context).size.width * widget.snippetWidthRatio,
            ),
          );
        }
      }
    );
  }

}
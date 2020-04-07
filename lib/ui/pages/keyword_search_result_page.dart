import 'package:app/bloc/search_result/keyword_search_result_bloc.dart';
import 'package:app/bloc/search_result/search_result_event.dart';
import 'package:app/bloc/search_result/search_result_state.dart';
import 'package:app/model/models.dart';
import 'package:app/ui/navigation_argument.dart';
import 'package:app/ui/widgets/loading.dart';
import 'package:app/ui/widgets/recipe_snippets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeywordSearchResultPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => KeywordSearchResultPageState();
}

class KeywordSearchResultPageState extends State<KeywordSearchResultPage> {
  String _title;
  KeywordSearchResultBloc _postBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Setup arguments and bloc inherited from context
    NavigationArgument args = ModalRoute.of(context).settings.arguments;
    _title = args['title'] ?? "No Title";
    _postBloc = BlocProvider.of<KeywordSearchResultBloc>(context);
    _postBloc.keyWords = args['title'] ?? "";

    return MultiBlocListener(
      // Setup navigation event listeners
      listeners: [
        BlocListener(
          bloc: BlocProvider.of<KeywordSearchResultBloc>(context),
          listener: (context, state) {
            if(state is GoToPrevPageState) {
              Navigator.pop(context);
            }
          },
        )
      ],

      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              _title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                  Icons.arrow_back_ios
              ),
              onPressed: () {
                _postBloc.add(GoToPrevPage());
              },
            ),
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
              child: _ScrollingResults()
          )
      )
    );
  }
}

class _ScrollingResults extends StatefulWidget {
  @override
  _ScrollingResultsState createState() =>  _ScrollingResultsState();
}

class _ScrollingResultsState extends State<_ScrollingResults> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  KeywordSearchResultBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<KeywordSearchResultBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeywordSearchResultBloc, SearchResultState>(
      builder: (context, state) {
        if (state is ResultUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ResultError) {
          return Center(
            child: Text(state.errorStr),
          );
        }
        if (state is ResultLoaded) {
          if (state.results.isEmpty) {
            return Center(
              child: NothingToLoadWidget()
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.results.length
                  ? BottomLoadingWidget()
                  : FutureBuilder<Recipe>(
                future: state.results[index],
                builder: (futureContext, futureData) {
                    if(futureData.hasError) {
                      if(index == state.previousLength)
                        return LoadingErrorWidget(
                            message: futureData.error.toString()
                        );
                    }
                    if(futureData.hasData) {
                      return RecipeSnippetWidget(
                          item: futureData.data
                      );
                    }
                    if(index == state.previousLength)
                      return BottomLoadingWidget();

                    return Container();
                  }
                );
            },
            itemCount: state.hasReachedMax
                ? state.results.length
                : state.results.length + 1,
            controller: _scrollController,
          );
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(FetchResult());
    }
  }
}


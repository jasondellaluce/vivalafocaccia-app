import 'package:app/legacy/bloc/search/search_bloc.dart';
import 'package:app/legacy/bloc/search/search_event.dart';
import 'package:app/legacy/bloc/search/search_state.dart';
import 'package:app/legacy/model/models.dart';
import 'package:app/legacy/ui/navigation_argument.dart';
import 'package:app/legacy/ui/widgets/category_snippets.dart';
import 'package:app/legacy/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_configuration/global_configuration.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      // Setup navigation event listeners
      listeners: [
        BlocListener(
          bloc: context.bloc<SearchBloc>(),
          listener: (context, state) {
            var argument = NavigationArgument();
            if (state is KeywordSelectedState) {
              argument['title'] = state.text;
              Navigator.pushNamed(context, "keywordSearchResult",
                  arguments: argument);
            }
          },
        ),

        // TODO: Real category page navigation
        BlocListener(
          bloc: context.bloc<SearchBloc>(),
          listener: (context, state) {
            var argument = NavigationArgument();
            if (state is CategorySelectedState) {
              argument['title'] = state.category.code;
              Navigator.pushNamed(context, "keywordSearchResult",
                  arguments: argument);
            }
          },
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(GlobalConfiguration().get("searchPageTitle")),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: ListView(
                children: <Widget>[
                  _SearchBar(),
                  SizedBox(height: 10.0),
                  _CategoryList(),
                  SizedBox(height: 10.0),
                ],
              ))),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  SearchBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<SearchBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextField(
          onSubmitted: (text) => _submitKeywords(),
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: GlobalConfiguration().get("searchPageBarPlaceholder"),
            prefixIcon: GestureDetector(
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onTap: _submitKeywords,
            ),
            suffixIcon: GestureDetector(
              child: Icon(Icons.clear),
              onTap: _clearKeywords,
            ),
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          maxLines: 1,
          controller: _textController,
          autocorrect: false,
        ),
      ),
    );
  }

  void _clearKeywords() {
    _textController.text = '';
    bloc.add(KeywordSelectedEvent(text: ''));
  }

  void _submitKeywords() {
    bloc.add(KeywordSelectedEvent(text: _textController.text));
    _textController.text = '';
  }
}

class _CategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryListState();
}

class _CategoryListState extends State<_CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (builderContext, state) {
          if (state is EmptyState) {
            return Wrap(
                spacing: MediaQuery.of(context).size.width /
                    20, // gap between adjacent chips
                runSpacing:
                    MediaQuery.of(context).size.width / 20, // gap between lines
                children: state.categoryList.map((futureCat) {
                  return FutureBuilder<Category>(
                    future: futureCat,
                    builder: (futureContext, snapshot) {
                      if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            context.bloc<SearchBloc>().add(
                                CategorySelectedEvent(category: snapshot.data));
                          },
                          child: CategorySnippetWidget(item: snapshot.data),
                        );
                      } else if (snapshot.hasError) {
                        return LoadingErrorWidget(
                          message: snapshot.error.toString(),
                        );
                      }
                      return BottomLoadingWidget();
                    },
                  );
                }).toList());
          }
          return Container();
        },
      ),
    );
  }
}

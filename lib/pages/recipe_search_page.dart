import 'package:app/bloc/recipe_search_bloc.dart';
import 'package:app/bloc/events/recipe_search_event.dart';
import 'package:app/bloc/states/recipe_search_state.dart';
import 'package:app/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class RecipeSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 40.0),
        Material(
          child: _SearchBar(),
        ),

        _SearchBody()],
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  RecipeSearchBloc _githubSearchBloc;

  @override
  void initState() {
    super.initState();
    _githubSearchBloc = BlocProvider.of<RecipeSearchBloc>(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _githubSearchBloc.add(
          TextChanged(text: text),
        );
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: GestureDetector(
          child: Icon(Icons.clear),
          onTap: _onClearTapped,
        ),
        border: InputBorder.none,
        hintText: 'Enter a search term',
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    _githubSearchBloc.add(TextChanged(text: ''));
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeSearchBloc, RecipeSearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return CircularProgressIndicator();
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess) {
          return state.items.isEmpty
              ? Text('No Results')
              : Expanded(child: _SearchResults(items: state.items));
        }
        return Text('Please enter a term to begin');
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<Future<Recipe>> items;

  const _SearchResults({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  final Future<Recipe> item;

  const _SearchResultItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe> (
      future: item,
      builder: (context, itemValue) {
        if(itemValue.hasData) {
          return ListTile(
            title: Text(itemValue.data.title),
          );
        }
        if(itemValue.hasError) {
          return Text(itemValue.error.toString());
        }
        return CircularProgressIndicator();
      },
    );
  }
}
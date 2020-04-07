
import 'package:app/bloc/search/search_bloc.dart';
import 'package:app/bloc/search/search_event.dart';
import 'package:app/bloc/search/search_state.dart';
import 'package:app/ui/navigation_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      // Setup navigation event listeners
      listeners: [
        BlocListener(
          bloc: BlocProvider.of<SearchBloc>(context),
          listener: (context, state) {
            var argument = MapNavigationArgument();
            if(state is KeywordSelectedState) {
              argument['title'] = state.text;
              Navigator.pushNamed(context, "keywordSearchResult", arguments: argument);
            }
          },
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text("Le ricette di VivaLaFocaccia"),
            centerTitle: true,
            automaticallyImplyLeading: false,

          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
              child: ListView(
                children: <Widget>[
                  _SearchBar(),
                  SizedBox(height: 10.0),
                  _CategoryList(),
                  SizedBox(height: 10.0),
                ],
              )
          )
      ),
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
    bloc = BlocProvider.of<SearchBloc>(context);
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
              borderSide: BorderSide(color: Colors.white,),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: "Parole per la ricerca...",
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

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Render cool category list
    return Container();
  }
}

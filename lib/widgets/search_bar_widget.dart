import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {

  final String textHint;
  final Function(BuildContext, TextEditingController, String) onSubmit;

  const SearchBarWidget({Key key, this.onSubmit, this.textHint}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  var _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        
        onSubmitted: (s) => widget.onSubmit(context, _textController, s),
        maxLines: 1,
        autocorrect: false,
        controller: _textController,
        decoration: InputDecoration(
          hintText: widget.textHint,
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}

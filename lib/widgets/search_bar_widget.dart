import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(TextEditingController, String) onSubmit;

  const SearchBarWidget({Key key, this.onSubmit}) : super(key: key);

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
        onSubmitted: (s) => widget.onSubmit(_textController, s),
        maxLines: 1,
        autocorrect: false,
        // controller: ,
        decoration: InputDecoration(
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

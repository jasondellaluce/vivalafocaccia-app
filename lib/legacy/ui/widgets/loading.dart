import 'package:flutter/material.dart';

// TODO: Real bottom loader
class BottomLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

// TODO: Real bottom loader error
class LoadingErrorWidget extends StatelessWidget {
  final String message;

  const LoadingErrorWidget({
    Key key,
    @required this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}

// TODO: real placeholder
class NothingToLoadWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('Got nothing to load bruh');
  }
}
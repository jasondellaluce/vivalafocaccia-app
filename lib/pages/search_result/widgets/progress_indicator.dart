
import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}
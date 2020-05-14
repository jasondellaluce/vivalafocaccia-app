import 'package:flutter/material.dart';

class HeaderLogoImageWidget extends StatelessWidget {
  final double logoWidthRatio;

  const HeaderLogoImageWidget({Key key, this.logoWidthRatio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: CircleBorder(),
      child: Container(
        width: MediaQuery.of(context).size.width * logoWidthRatio,
        height: MediaQuery.of(context).size.width * logoWidthRatio,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/foto-vittorio.jpg")),
            boxShadow: [BoxShadow()]),
      ),
    );
  }
}

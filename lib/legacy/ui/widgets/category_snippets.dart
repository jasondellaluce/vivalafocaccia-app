import 'package:app/legacy/model/models.dart';
import 'package:app/legacy/ui/widgets/picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategorySnippetWidget extends StatelessWidget {
  final Category item;

  const CategorySnippetWidget ({
    Key key,
    @required this.item,
  }) : super(key: key);

  final screenProportion = 2.25;
  final borderRadius = 10.0;
  final imageOpacity = 0.75;
  final textLineLength = 18;
  final textBackgroundLines = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / screenProportion,
      height: MediaQuery.of(context).size.width / screenProportion,
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          elevation: 8.0,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    child: Opacity(
                      opacity: imageOpacity,
                      child: PictureWidget.fromUrl(
                          fit: BoxFit.cover,
                          imageUrl: item.featuredImageUrl
                      ),
                    )
                ),
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.white70,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / textLineLength * textBackgroundLines,
                    child: Center(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / textLineLength,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }

}
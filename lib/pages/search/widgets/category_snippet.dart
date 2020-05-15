import 'package:app/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class CategorySnippetWidget extends StatelessWidget {

  final Category category;
  final double width;
  final Function(BuildContext, Category) onTap;

  const CategorySnippetWidget({Key key, this.category, this.onTap, this.width}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context, category),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 10,
            shape: CircleBorder(),
            child: Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(category.featuredImageUrl)
                ),
                boxShadow: [BoxShadow()]
              ),
            ),
          ),

          SizedBox(height: 5),

          Container(
            width: width,
            child: Text(
              parse(category.name).documentElement.text.trim(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
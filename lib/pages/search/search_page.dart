
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/widgets/widgets.dart';

import 'widgets/category_collection.dart';

class SearchPage extends StatelessWidget {

  final pagePadding = EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20);

  @override
  Widget build(BuildContext context) {
    print("Building: SearchPage");
    var localization = Provider.of<LocalizationService>(context, listen: false);
    return Consumer<BlogContentService>(
      builder: (context, service, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: pagePadding,
                child: Column(
                  children: <Widget>[
                    SearchBarWidget(
                      textHint: localization["placeholderKeywordSearchField"],
                      onSubmit: _onSearchSubmit
                    ),
                    SizedBox(height: 30),
                    CategoryCollectionWidget(
                      categoryListFuture : service.getCategories(),
                      snippetWidth: 130,
                      spacing: 20,
                      onCategorySelection: _onCategorySelected,
                    )
                  ],
                ),
              ),
            )
          ),
        );
      }
    );
  }

  void _onSearchSubmit(BuildContext context, TextEditingController controller, String searchValue) {
    // TODO: Navigate to search results by keyword
  }


  void _onCategorySelected(BuildContext context, Category search) {
    // TODO: Navigate to search results by category
  }

}
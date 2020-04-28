
import 'dart:convert';

import 'package:app/legacy/model/models.dart';
import 'abstract_wp_rest_post_repository.dart';

class WPRestPostRepository
    extends AbstractWpRestPostTypeRepository<Post, PostOrder>
    implements PostRepository {

  WPRestPostRepository(String websiteUrl) : super(websiteUrl);


  @override
  String formatOrderType(PostOrder order) {
    switch(order) {
      case PostOrder.date: return "date";
      case PostOrder.relevance: return "relevance";
    }
    return "";
  }

  @override
  String get wpRestRoute => "posts";

  @override
  Post parseJson(String jsonBody) {
    Map<String, dynamic> jsonObj = json.decode(jsonBody);
    return Post(
        int.parse(jsonObj['id'].toString()),
        int.parse(jsonObj['author'].toString()),
        jsonObj['slug'].toString(),
        jsonObj['title']['rendered'].toString(),
        jsonObj['content']['rendered'].toString(),
        jsonObj['author_name'].toString(),
        jsonObj['link'].toString(),
        jsonObj['featured_image_url'],
        DateTime.parse(jsonObj['date_gmt']),
        DateTime.parse(jsonObj['modified_gmt'])
    );
  }

}
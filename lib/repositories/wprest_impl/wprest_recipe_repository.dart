
import 'package:app/models/models.dart';
import 'abstract_wprest_repository.dart';
import '../common.dart';
import '../recipe_repository.dart';

class WpRestRecipeRepository extends AbstractWpRestRepository<Recipe>
    implements RecipeRepository {
  final String urlBase;
  final String urlEndpoint = "/wp-json/wp/v2/recipes";

  WpRestRecipeRepository(httpClient, this.urlBase) : super(httpClient);

  RecipeIngredient _parseJsonRecipeIngredient(Map<String, dynamic> json) {
    return RecipeIngredient(
      isTitle : json['is_separator'].toString().toLowerCase() == "true",
      name : json['name'].toString(),
      note : json['note'].toString(),
      quantity : json['amount'].toString(),
    );
  }

  RecipeStep _parseJsonRecipeStep(Map<String, dynamic> json) {
    List<dynamic> imageList = json['images'];
    return RecipeStep(
        title: json['title'].toString(),
        duration : json['duration'].toString(),
        description : json['description'].toString(),
        featuredImageUrlList :
          imageList.map((e) => e['full_image_url'].toString()).toList()
    );
  }

  @override
  parseJsonMap(Map<String, dynamic> map) {
    List<dynamic> ingredientList = map['recipe_ingredients'];
    List<dynamic> stepList = map['recipe_steps'];
    // TODO: Extract video link, featured img form content, images form steps. also filter content, find calculators
    return Recipe(
        id: int.parse(map['id'].toString()),
        authorId : int.parse(map['author'].toString()),
        code : map['slug'].toString(),
        title : map['title']['rendered'].toString(),
        content : map['content']['rendered'].toString(),
        authorName : map['author_name'].toString(),
        pageUrl : map['link'].toString(),
        featuredImageUrl : map['featured_image_url'],
        creationDateTime : DateTime.parse(map['date_gmt']),
        lastUpdateDateTime : DateTime.parse(map['modified_gmt']),
        servesCount : int.tryParse(map['recipe_serves'].toString()) ?? 0,
        votesCount : int.tryParse(map['recipe_like_count'].toString()) ?? 0,
        ratingsCount : int.tryParse(map['recipe_like_count'].toString()) ?? 0,
        averageRating: double.tryParse(map['recipe_review_avg_rating'].toString()),
        cookingTime : map['recipe_cooking_time'].toString(),
        cookingTemperature : map['recipe_cooking_temperature'].toString(),
        difficulty : map['recipe_difficulty'].toString(),
        description : map['recipe_quick_description'].toString(),
        ingredientList : ingredientList.map(
                (e) => _parseJsonRecipeIngredient(e)).toList(),
        stepList : stepList.map((e) => _parseJsonRecipeStep(e)).toList()
    );
  }

  String _formatPostOrderBy(RecipeOrderBy order) {
    switch(order) {
      case RecipeOrderBy.date: return "date";
      case RecipeOrderBy.relevance: return "relevance";
      default: return null;
    }
  }

  @override
  Future<Recipe> read(RecipeSingleReadRequest request) {
    if(request.id != null && request.code != null)
      throw new RepositoryInvalidRequestError("Can't read both by id and code");

    if(request.id != null) {
      String url = urlEndpoint + "/" + request.id.toString();
      return delegateRead(urlBase, url, {}, {});
    }

    if(request.code != null) {
      Map<String, String> query = Map();
      query['slug'] = request.code;
      return delegateRead(urlBase, urlEndpoint, query, {});
    }

    throw new RepositoryInvalidRequestError("Should specify id or code");
  }

  @override
  Future<List<Recipe>> readMany(RecipeMultiReadRequest request) {
    Map<String, String> query = Map();
    query['categories'] = request.categoryId?.toString() ?? null;
    query['search'] = request.keyWordQuery ?? null;
    query['offset'] = request.readOffset?.toString() ?? null;
    query['per_page'] = request.readCount?.toString() ?? null;
    query['orderby'] = _formatPostOrderBy(request.orderBy) ?? null;
    query['order'] = formatResultOrderType(request.order) ?? null;

    return delegateReadMany(urlBase, urlEndpoint, query, {});
  }

}
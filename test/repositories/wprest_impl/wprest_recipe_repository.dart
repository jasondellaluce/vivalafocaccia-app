
import 'package:app/core/third_party/network_http_interface.dart';
import 'package:app/repositories/repositories.dart';

import 'package:app/repositories/wprest_impl/wprest_recipe_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  RecipeRepository repository;

  setUp(() {
    repository = new WpRestRecipeRepository(
        NetworkHttpInterface(), 'vivalafocaccia.com');
  });

  group("WpRestRecipeRepository - read()", () {
    test("read() correctly fetches without parameters", () {
      var request = RecipeSingleReadRequest(code: "video-ricetta-della-focaccia-genovese");
      var result = repository.read(request);
      expect(result, completion(isNot(contains(null))));
    });
  });

  group("WpRestRecipeRepository - readMany()", () {

    test("readMany() correctly fetches without parameters", () {
      var request = RecipeMultiReadRequest();
      var result = repository.readMany(request);
      expect(result.then((value) => value.length > 0),
          completion(equals(true)));
      expect(result, completion(isNot(contains(null))));
    });

    test("readMany() correctly fetches with requested count", () {
      var request = RecipeMultiReadRequest(
          readCount: 2
      );
      var result = repository.readMany(request);
      expect(result, completion(isNot(contains(null))));
      expect(result.then((value) => value.length), completion(equals(2)));
    });

    test("readMany() correctly fetches with ordering", () {
      var request = RecipeMultiReadRequest(
          orderBy: RecipeOrderBy.date,
          order: ReadOrderType.desc
      );
      var result = repository.readMany(request);
      expect(result, completion(isNot(contains(null))));
      expect(result.then((value) =>
          value[0].creationDateTime.isAfter(value[1].creationDateTime)),
          completion(equals(true)));
    });

  });

}
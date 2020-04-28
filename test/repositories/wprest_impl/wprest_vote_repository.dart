
import 'package:app/core/http_interface.dart';
import 'package:app/models/models.dart';
import 'package:app/repositories/repositories.dart';
import 'package:app/repositories/wprest_impl/wprest_vote_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  VoteRepository repository;

  setUp(() {
    repository = new WpRestVoteRepository(
        NetworkHttpInterface(),
        'vivalafocaccia.com');
  });

  group("WpRestVoteRepository - read()", () {

    test("read() reads correctly", () {
      var request = VoteReadRequest(postId: 6919);
      var result = repository.read(request);
      expect(result, completion(isNot(equals(null))));
      expect(result.then((value) => value.postId), completion(equals(6919)));
    });

  });

  group("WpRestVoteRepository - create()", () {

    test("create() new positive vote", () async {
      var readRequest = VoteReadRequest(postId: 6919);
      var readResult = repository.read(readRequest);
      expect(readResult, completion(isNot(equals(null))));
      expect(readResult.then((value) => value.postId), completion(equals(6919)));
      Vote oldVote = await readResult;

      var request = VoteCreateRequest(postId: 6919, isPositive: true);
      var result = repository.create(request);
      expect(result, completion(isNot(equals(null))));
      expect(result.then((value) => value.postId), completion(equals(6919)));
      expect(result.then((value) => value.positiveCount),
          completion(equals(oldVote.positiveCount + 1)));
    });

    test("create() new negative vote", () async {
      var readRequest = VoteReadRequest(postId: 6919);
      var readResult = repository.read(readRequest);
      expect(readResult, completion(isNot(equals(null))));
      expect(readResult.then((value) => value.postId), completion(equals(6919)));
      Vote oldVote = await readResult;

      var request = VoteCreateRequest(postId: 6919, isPositive: false);
      var result = repository.create(request);
      expect(result, completion(isNot(equals(null))));
      expect(result.then((value) => value.postId), completion(equals(6919)));
      expect(result.then((value) => value.positiveCount),
          completion(equals(oldVote.positiveCount - 1)));
    });

  });

}
import "dart:io";

import "package:app_api/api.dart";
import "package:app_api/src/data/in_memory_feed_data_source.dart";
import "package:dart_frog/dart_frog.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

import "../../../routes/api/v1/search/popular.dart" as route;

class _MockFeedDataSource extends Mock implements FeedDataSource {}

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group("GET /api/v1/search/popular", () {
    late FeedDataSource feedDataSource;

    setUp(() {
      feedDataSource = _MockFeedDataSource();
    });

    test("responds with a 200 on success.", () async {
      final expected = PopularSearchResponse(
        articles: popularArticles.map((item) => item.post).toList(),
        topics: popularTopics,
      );
      when(() => feedDataSource.getPopularArticles()).thenAnswer(
        (_) async => expected.articles,
      );
      when(
        () => feedDataSource.getPopularTopics(),
      ).thenAnswer((_) async => expected.topics);
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals(expected.toJson())));
      verify(() => feedDataSource.getPopularArticles()).called(1);
      verify(() => feedDataSource.getPopularTopics()).called(1);
    });
  });

  test("responds with 405 when method is not GET.", () async {
    final request = Request("POST", Uri.parse("http://127.0.0.1/"));
    final context = _MockRequestContext();
    when(() => context.request).thenReturn(request);
    final response = await route.onRequest(context);
    expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
  });
}

import "dart:io";

import "package:dart_frog/dart_frog.dart";
import "package:app_api/api.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

import "../../../../routes/api/v1/articles/[id]/index.dart" as route;

class _MockFeedDataSource extends Mock implements FeedDataSource {}

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequestUser extends Mock implements RequestUser {}

void main() {
  const id = "__test_article_id__";
  group("GET /api/v1/articles/<id>", () {
    late FeedDataSource feedDataSource;

    setUp(() {
      feedDataSource = _MockFeedDataSource();
    });

    test("responds with a 404 when article not found (isPremium)", () async {
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => null);
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.notFound));
    });

    test("responds with a 404 when article not found (getArticle)", () async {
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => false);
      when(
        () => feedDataSource.getArticle(id: id),
      ).thenAnswer((_) async => null);
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.notFound));
    });

    test(
        "responds with a 200 and full article "
        "when article is not premium", () async {
      final url = Uri.parse("https://dailyglobe.com");
      final article = Article(
        title: "title",
        blocks: const [],
        totalBlocks: 0,
        url: url,
      );
      when(
        () => feedDataSource.getArticle(id: id),
      ).thenAnswer((_) async => article);
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => false);
      final expected = ArticleResponse(
        title: article.title,
        content: article.blocks,
        totalCount: article.totalBlocks,
        url: url,
        isPremium: false,
        isPreview: false,
      );
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(await response.json(), equals(expected.toJson()));
    });

    test(
        "responds with a 200 and article preview "
        "when article preview is requested", () async {
      final url = Uri.parse("https://dailyglobe.com");
      final article = Article(
        title: "title",
        blocks: const [],
        totalBlocks: 0,
        url: url,
      );
      when(
        () => feedDataSource.getArticle(id: id, preview: true),
      ).thenAnswer((_) async => article);
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => false);
      final expected = ArticleResponse(
        title: article.title,
        content: article.blocks,
        totalCount: article.totalBlocks,
        url: url,
        isPremium: false,
        isPreview: true,
      );
      final request = Request(
        "GET",
        Uri.parse("http://127.0.0.1/").replace(
          queryParameters: {"preview": "true"},
        ),
      );
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      when(() => context.read<RequestUser>()).thenReturn(RequestUser.anonymous);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(await response.json(), equals(expected.toJson()));
    });

    test(
        "responds with a 200 and article preview "
        "when article is premium and user is anonymous", () async {
      final url = Uri.parse("https://dailyglobe.com");
      final article = Article(
        title: "title",
        blocks: const [],
        totalBlocks: 0,
        url: url,
      );
      when(
        () => feedDataSource.getArticle(id: id, preview: true),
      ).thenAnswer((_) async => article);
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => true);
      final expected = ArticleResponse(
        title: article.title,
        content: article.blocks,
        totalCount: article.totalBlocks,
        url: url,
        isPremium: true,
        isPreview: true,
      );
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      when(() => context.read<RequestUser>()).thenReturn(RequestUser.anonymous);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(await response.json(), equals(expected.toJson()));
    });

    test(
        "responds with a 200 and article preview "
        "when article is premium and user is not found", () async {
      const userId = "__test_user_id__";
      final url = Uri.parse("https://dailyglobe.com");
      final article = Article(
        title: "title",
        blocks: const [],
        totalBlocks: 0,
        url: url,
      );
      when(
        () => feedDataSource.getArticle(id: id, preview: true),
      ).thenAnswer((_) async => article);
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => true);
      when(
        () => feedDataSource.getUser(userId: userId),
      ).thenAnswer((_) async => null);
      final expected = ArticleResponse(
        title: article.title,
        content: article.blocks,
        totalCount: article.totalBlocks,
        url: url,
        isPremium: true,
        isPreview: true,
      );
      final requestUser = _MockRequestUser();
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => requestUser.id).thenReturn(userId);
      when(() => requestUser.isAnonymous).thenReturn(false);
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      when(() => context.read<RequestUser>()).thenReturn(requestUser);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(await response.json(), equals(expected.toJson()));
    });

    test(
        "responds with a 200 and article preview "
        "when article is premium and user has no subscription plan", () async {
      const userId = "__test_user_id__";
      const user = User(id: userId, subscription: SubscriptionPlan.none);
      final url = Uri.parse("https://dailyglobe.com");
      final article = Article(
        title: "title",
        blocks: const [],
        totalBlocks: 0,
        url: url,
      );
      when(
        () => feedDataSource.getArticle(id: id, preview: true),
      ).thenAnswer((_) async => article);
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => true);
      when(
        () => feedDataSource.getUser(userId: userId),
      ).thenAnswer((_) async => user);
      final expected = ArticleResponse(
        title: article.title,
        content: article.blocks,
        totalCount: article.totalBlocks,
        url: url,
        isPremium: true,
        isPreview: true,
      );
      final requestUser = _MockRequestUser();
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => requestUser.id).thenReturn(userId);
      when(() => requestUser.isAnonymous).thenReturn(false);
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      when(() => context.read<RequestUser>()).thenReturn(requestUser);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(await response.json(), equals(expected.toJson()));
    });

    test(
        "responds with a 200 and full article "
        "when article is premium and user has a subscription plan", () async {
      const userId = "__test_user_id__";
      const user = User(id: userId, subscription: SubscriptionPlan.basic);
      final url = Uri.parse("https://dailyglobe.com");
      final article = Article(
        title: "title",
        blocks: const [],
        totalBlocks: 0,
        url: url,
      );
      when(
        () => feedDataSource.getArticle(id: id),
      ).thenAnswer((_) async => article);
      when(
        () => feedDataSource.isPremiumArticle(id: id),
      ).thenAnswer((_) async => true);
      when(
        () => feedDataSource.getUser(userId: userId),
      ).thenAnswer((_) async => user);
      final expected = ArticleResponse(
        title: article.title,
        content: article.blocks,
        totalCount: article.totalBlocks,
        url: url,
        isPremium: true,
        isPreview: false,
      );
      final requestUser = _MockRequestUser();
      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => requestUser.id).thenReturn(userId);
      when(() => requestUser.isAnonymous).thenReturn(false);
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      when(() => context.read<RequestUser>()).thenReturn(requestUser);
      final response = await route.onRequest(context, id);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(await response.json(), equals(expected.toJson()));
    });
  });

  test("responds with 405 when method is not GET.", () async {
    final request = Request("POST", Uri.parse("http://127.0.0.1/"));
    final context = _MockRequestContext();
    when(() => context.request).thenReturn(request);
    final response = await route.onRequest(context, id);
    expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
  });
}

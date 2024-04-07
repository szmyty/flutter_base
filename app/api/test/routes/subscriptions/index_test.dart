// ignore_for_file: prefer_const_constructors

import "dart:io";

import "package:app_api/api.dart";
import "package:dart_frog/dart_frog.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

import "../../../routes/api/v1/subscriptions/index.dart" as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockFeedDataSource extends Mock implements FeedDataSource {}

class _MockRequestUser extends Mock implements RequestUser {}

void main() {
  late FeedDataSource feedDataSource;

  setUp(() {
    feedDataSource = _MockFeedDataSource();
  });

  group("GET /api/v1/subscriptions", () {
    test("returns a 200 on success", () async {
      final subscription = Subscription(
        id: "a",
        name: SubscriptionPlan.plus,
        cost: SubscriptionCost(
          annual: 4200,
          monthly: 1200,
        ),
        benefits: const ["benefitA"],
      );

      when(
        () => feedDataSource.getSubscriptions(),
      ).thenAnswer((_) async => [subscription]);

      final expected = SubscriptionsResponse(subscriptions: [subscription]);

      final request = Request("GET", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals(expected.toJson())));
      verify(() => feedDataSource.getSubscriptions()).called(1);
    });
  });

  group("POST /api/v1/subscriptions", () {
    test("responds with a 400 when user is anonymous.", () async {
      final request = Request("POST", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<RequestUser>()).thenReturn(RequestUser.anonymous);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test("responds with a 400 when subscriptionId is missing.", () async {
      final request = Request("POST", Uri.parse("http://127.0.0.1/"));
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<RequestUser>()).thenReturn(RequestUser.anonymous);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test("responds with a 201 on success.", () async {
      const userId = "__userId__";
      const subscriptionId = "__subscription_id__";
      final request = Request(
        "POST",
        Uri.parse("http://127.0.0.1/").replace(
          queryParameters: <String, String>{
            "subscriptionId": subscriptionId,
          },
        ),
      );
      final user = _MockRequestUser();
      when(() => user.id).thenReturn(userId);
      when(() => user.isAnonymous).thenReturn(false);
      final context = _MockRequestContext();
      when(() => context.request).thenReturn(request);
      when(() => context.read<FeedDataSource>()).thenReturn(feedDataSource);
      when(() => context.read<RequestUser>()).thenReturn(user);
      when(
        () => feedDataSource.createSubscription(
          userId: any(named: "userId"),
          subscriptionId: any(named: "subscriptionId"),
        ),
      ).thenAnswer((_) async {});

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.created));
      verify(
        () => feedDataSource.createSubscription(
          userId: userId,
          subscriptionId: subscriptionId,
        ),
      ).called(1);
    });
  });

  test("responds with 405 when method is not POST.", () async {
    final request = Request("PUT", Uri.parse("http://127.0.0.1/"));
    final context = _MockRequestContext();
    when(() => context.request).thenReturn(request);
    final response = await route.onRequest(context);
    expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
  });
}

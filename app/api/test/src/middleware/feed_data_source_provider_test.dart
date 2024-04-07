import "package:app_api/api.dart";
import "package:dart_frog/dart_frog.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group("feedDataSourceProvider", () {
    test("provides a FeedDataSource instance", () async {
      FeedDataSource? value;
      final context = _MockRequestContext();
      final handler = feedDataSourceProvider()(
        (_) {
          value = context.read<FeedDataSource>();
          return Response(body: "");
        },
      );
      final request = Request.get(Uri.parse("http://localhost/"));
      when(() => context.request).thenReturn(request);

      when(() => context.read<FeedDataSource>())
          .thenReturn(InMemoryFeedDataSource());

      when(() => context.provide<FeedDataSource>(any())).thenReturn(context);
      when(() => context.provide<RequestUser>(any())).thenReturn(context);

      await handler(context);
      expect(value, isNotNull);
    });
  });
}

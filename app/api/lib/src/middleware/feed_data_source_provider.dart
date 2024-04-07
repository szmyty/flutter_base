import "package:app_api/api.dart";
import "package:dart_frog/dart_frog.dart";

final _feedDataSource = InMemoryNewsDataSource();

/// Provider a [FeedDataSource] to the current [RequestContext].
Middleware feedDataSourceProvider() {
  return (handler) {
    return handler.use(provider<FeedDataSource>((_) => _feedDataSource));
  };
}

import "package:app_api/api.dart";
import "package:feed_blocks/feed_blocks.dart";

/// {@template feed_data_source}
/// An interface for a content data source.
/// {@endtemplate}
abstract class FeedDataSource {
  /// {@macro feed_data_source}
  const FeedDataSource();

  /// Returns a [Article] for the provided article [id].
  ///
  /// In addition, the contents can be paginated by supplying
  /// [limit] and [offset].
  ///
  /// * [limit] - The number of content blocks to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  /// * [preview] - Whether to return a preview of the article.
  ///
  /// Returns `null` if there is no article with the provided [id].
  Future<Article?> getArticle({
    required String id,
    int limit = 20,
    int offset = 0,
    bool preview = false,
  });

  /// Returns whether the article with the associated [id] is a premium article.
  ///
  /// Returns `null` if there is no article with the provided [id].
  Future<bool?> isPremiumArticle({required String id});

  /// Returns a list of current popular topics.
  Future<List<String>> getPopularTopics();

  /// Returns a list of current relevant topics
  /// based on the provided [term].
  Future<List<String>> getRelevantTopics({required String term});

  /// Returns a list of current popular article blocks.
  Future<List<FeedBlock>> getPopularArticles();

  /// Returns a list of relevant article blocks
  /// based on the provided [term].
  Future<List<FeedBlock>> getRelevantArticles({required String term});

  /// Returns [RelatedArticles] for the provided article [id].
  ///
  /// In addition, the contents can be paginated by supplying
  /// [limit] and [offset].
  ///
  /// * [limit] - The number of content blocks to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  Future<RelatedArticles> getRelatedArticles({
    required String id,
    int limit = 20,
    int offset = 0,
  });

  /// Returns a [Feed] for the provided [category].
  /// By default [Category.top] is used.
  ///
  /// In addition, the feed can be paginated by supplying
  /// [limit] and [offset].
  ///
  /// * [limit] - The number of results to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  Future<Feed> getFeed({
    Category category = Category.top,
    int limit = 20,
    int offset = 0,
  });

  /// Returns a list of all available categories.
  Future<List<Category>> getCategories();

  /// Subscribes the user with the associated [userId] to
  /// the subscription with the associated [subscriptionId].
  Future<void> createSubscription({
    required String userId,
    required String subscriptionId,
  });

  /// Returns a list of all available subscriptions.
  Future<List<Subscription>> getSubscriptions();

  /// Returns the user associated with the provided [userId].
  /// Returns `null` if there is no user with the provided [userId].
  Future<User?> getUser({required String userId});
}

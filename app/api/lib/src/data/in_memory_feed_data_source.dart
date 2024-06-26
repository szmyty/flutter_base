import "dart:math" as math;

import "package:app_api/api.dart";
import "package:app_api/src/data/models/models.dart";
import "package:collection/collection.dart";
import "package:feed_blocks/feed_blocks.dart";

part "static_feed_data.dart";

/// {@template in_memory_feed_data_source}
/// An implementation of [FeedDataSource] which
/// is powered by in-memory content.
/// {@endtemplate}
class InMemoryFeedDataSource implements FeedDataSource {
  /// {@macro in_memory_feed_data_store}
  InMemoryFeedDataSource() : _userSubscriptions = <String, String>{};

  final Map<String, String> _userSubscriptions;

  @override
  Future<void> createSubscription({
    required String userId,
    required String subscriptionId,
  }) async {
    final subscriptionPlan = subscriptions
        .firstWhereOrNull((subscription) => subscription.id == subscriptionId)
        ?.name;

    if (subscriptionPlan != null) {
      _userSubscriptions[userId] = subscriptionPlan.name;
    }
  }

  @override
  Future<List<Subscription>> getSubscriptions() async => subscriptions;

  @override
  Future<Article?> getArticle({
    required String id,
    int limit = 20,
    int offset = 0,
    bool preview = false,
  }) async {
    final result = _feedItems.where((item) => item.post.id == id);
    if (result.isEmpty) return null;
    final articleFeedItem = result.first;
    final article = (preview
            ? articleFeedItem.contentPreview
            : articleFeedItem.content)
        .toArticle(title: articleFeedItem.post.title, url: articleFeedItem.url);
    final totalBlocks = article.totalBlocks;
    final normalizedOffset = math.min(offset, totalBlocks);
    final blocks =
        article.blocks.sublist(normalizedOffset).take(limit).toList();
    return Article(
      title: article.title,
      blocks: blocks,
      totalBlocks: totalBlocks,
      url: article.url,
    );
  }

  @override
  Future<bool?> isPremiumArticle({required String id}) async {
    final result = _feedItems.where((item) => item.post.id == id);
    if (result.isEmpty) return null;
    return result.first.post.isPremium;
  }

  @override
  Future<List<FeedBlock>> getPopularArticles() async {
    return popularArticles.map((item) => item.post).toList();
  }

  @override
  Future<List<FeedBlock>> getRelevantArticles({required String term}) async {
    return relevantArticles.map((item) => item.post).toList();
  }

  @override
  Future<List<String>> getRelevantTopics({required String term}) async {
    return relevantTopics;
  }

  @override
  Future<List<String>> getPopularTopics() async => popularTopics;

  @override
  Future<RelatedArticles> getRelatedArticles({
    required String id,
    int limit = 20,
    int offset = 0,
  }) async {
    final result = _feedItems.where((item) => item.post.id == id);
    if (result.isEmpty) return const RelatedArticles.empty();
    final articles = result.first.relatedArticles;
    final totalBlocks = articles.length;
    final normalizedOffset = math.min(offset, totalBlocks);
    final blocks = articles.sublist(normalizedOffset).take(limit).toList();
    return RelatedArticles(blocks: blocks, totalBlocks: totalBlocks);
  }

  @override
  Future<Feed> getFeed({
    Category category = Category.top,
    int limit = 20,
    int offset = 0,
  }) async {
    final feed =
        _newsFeedData[category] ?? const Feed(blocks: [], totalBlocks: 0);
    final totalBlocks = feed.totalBlocks;
    final normalizedOffset = math.min(offset, totalBlocks);
    final blocks = feed.blocks.sublist(normalizedOffset).take(limit).toList();
    return Feed(blocks: blocks, totalBlocks: totalBlocks);
  }

  @override
  Future<List<Category>> getCategories() async => _newsFeedData.keys.toList();

  @override
  Future<User> getUser({required String userId}) async {
    final subscription = _userSubscriptions[userId];
    if (subscription == null) {
      return User(id: userId, subscription: SubscriptionPlan.none);
    }
    return User(
      id: userId,
      subscription: SubscriptionPlan.values.firstWhere(
        (e) => e.name == subscription,
      ),
    );
  }
}

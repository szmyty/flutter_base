// ignore_for_file: prefer_const_constructors

import "package:app_api/api.dart";
import "package:app_api/src/data/in_memory_feed_data_source.dart";
import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

class MyFeedDataSource extends FeedDataSource {
  @override
  Future<void> createSubscription({
    required String userId,
    required String subscriptionId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Article?> getArticle({
    required String id,
    int limit = 20,
    int offset = 0,
    bool preview = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isPremiumArticle({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<Feed> getFeed({
    Category category = Category.top,
    int limit = 20,
    int offset = 0,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getCategories() => throw UnimplementedError();

  @override
  Future<RelatedArticles> getRelatedArticles({
    required String id,
    int limit = 20,
    int offset = 0,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<FeedBlock>> getPopularArticles() {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getPopularTopics() {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getRelevantTopics({required String term}) {
    throw UnimplementedError();
  }

  @override
  Future<List<FeedBlock>> getRelevantArticles({required String term}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Subscription>> getSubscriptions() {
    throw UnimplementedError();
  }

  @override
  Future<User?> getUser({required String userId}) {
    throw UnimplementedError();
  }
}

void main() {
  Matcher articleHaving({required List<FeedBlock> blocks, int? totalBlocks}) {
    return predicate<Article>(
      (article) {
        totalBlocks ??= article.totalBlocks;
        if (blocks.length != article.blocks.length) return false;
        if (totalBlocks != article.totalBlocks) return false;
        for (var i = 0; i < blocks.length; i++) {
          if (blocks[i] != article.blocks[i]) return false;
        }
        return true;
      },
    );
  }

  Matcher relatedArticlesHaving({
    required List<FeedBlock> blocks,
    int? totalBlocks,
  }) {
    return predicate<RelatedArticles>(
      (relatedArticles) {
        totalBlocks ??= relatedArticles.totalBlocks;
        if (blocks.length != relatedArticles.blocks.length) return false;
        if (totalBlocks != relatedArticles.totalBlocks) return false;
        for (var i = 0; i < blocks.length; i++) {
          if (blocks[i] != relatedArticles.blocks[i]) return false;
        }
        return true;
      },
    );
  }

  Matcher feedHaving({required List<FeedBlock> blocks, int? totalBlocks}) {
    return predicate<Feed>(
      (feed) {
        totalBlocks ??= feed.totalBlocks;
        if (blocks.length != feed.blocks.length) return false;
        if (totalBlocks != feed.totalBlocks) return false;
        for (var i = 0; i < blocks.length; i++) {
          if (blocks[i] != feed.blocks[i]) return false;
        }
        return true;
      },
    );
  }

  Matcher isAnEmptyFeed() {
    return predicate<Feed>(
      (feed) => feed.blocks.isEmpty && feed.totalBlocks == 0,
    );
  }

  group("FeedDataSource", () {
    test("can be extended", () {
      expect(MyFeedDataSource.new, returnsNormally);
    });
  });

  group("InMemoryFeedDataSource", () {
    late FeedDataSource feedDataSource;

    setUp(() {
      feedDataSource = InMemoryFeedDataSource();
    });

    group("createSubscription", () {
      test("completes", () async {
        expect(
          feedDataSource.createSubscription(
            userId: "userId",
            subscriptionId: "subscriptionId",
          ),
          completes,
        );
      });
    });

    group("getSubscriptions", () {
      test("returns list of subscriptions", () async {
        expect(
          feedDataSource.getSubscriptions(),
          completion(equals(subscriptions)),
        );
      });
    });

    group("getUser", () {
      test(
          "completes with empty user "
          "when subscription does not exist", () async {
        const userId = "userId";
        expect(
          feedDataSource.getUser(userId: userId),
          completion(User(id: userId, subscription: SubscriptionPlan.none)),
        );
      });

      test("completes with user when user exists", () async {
        const userId = "userId";
        final subscription = subscriptions.first;
        await feedDataSource.createSubscription(
          userId: userId,
          subscriptionId: subscription.id,
        );
        expect(
          feedDataSource.getUser(userId: userId),
          completion(
            equals(
              User(id: userId, subscription: subscription.name),
            ),
          ),
        );
      });
    });

    group("getFeed", () {
      test("returns stubbed feed (default category)", () {
        expect(
          feedDataSource.getFeed(limit: 100),
          completion(feedHaving(blocks: topNewsFeedBlocks)),
        );
      });

      test("returns stubbed feed (Category.technology)", () {
        expect(
          feedDataSource.getFeed(category: Category.technology),
          completion(feedHaving(blocks: technologyFeedBlocks)),
        );
      });

      test("returns stubbed feed (Category.sports)", () {
        expect(
          feedDataSource.getFeed(category: Category.sports),
          completion(feedHaving(blocks: sportsFeedBlocks)),
        );
      });

      test("returns empty feed for remaining categories", () async {
        final emptyCategories = [
          Category.business,
          Category.entertainment,
        ];
        for (final category in emptyCategories) {
          await expectLater(
            feedDataSource.getFeed(category: category),
            completion(isAnEmptyFeed()),
          );
        }
      });

      test("returns correct feed when limit is specified", () {
        expect(
          feedDataSource.getFeed(limit: 0),
          completion(
            feedHaving(blocks: [], totalBlocks: topNewsFeedBlocks.length),
          ),
        );

        expect(
          feedDataSource.getFeed(limit: 1),
          completion(
            feedHaving(
              blocks: topNewsFeedBlocks.take(1).toList(),
              totalBlocks: topNewsFeedBlocks.length,
            ),
          ),
        );

        expect(
          feedDataSource.getFeed(limit: 100),
          completion(
            feedHaving(
              blocks: topNewsFeedBlocks,
              totalBlocks: topNewsFeedBlocks.length,
            ),
          ),
        );
      });

      test("returns correct feed when offset is specified", () {
        expect(
          feedDataSource.getFeed(offset: 1, limit: 100),
          completion(
            feedHaving(
              blocks: topNewsFeedBlocks.sublist(1),
              totalBlocks: topNewsFeedBlocks.length,
            ),
          ),
        );

        expect(
          feedDataSource.getFeed(offset: 2, limit: 100),
          completion(
            feedHaving(
              blocks: topNewsFeedBlocks.sublist(2),
              totalBlocks: topNewsFeedBlocks.length,
            ),
          ),
        );

        expect(
          feedDataSource.getFeed(offset: 100, limit: 100),
          completion(
            feedHaving(
              blocks: [],
              totalBlocks: topNewsFeedBlocks.length,
            ),
          ),
        );
      });
    });

    group("getCategories", () {
      test("returns stubbed categories", () {
        expect(
          feedDataSource.getCategories(),
          completion([
            Category.top,
            Category.technology,
            Category.sports,
            Category.health,
            Category.science,
          ]),
        );
      });
    });

    group("getArticle", () {
      test("returns null when article id cannot be found", () {
        expect(
          feedDataSource.getArticle(id: "__invalid_article_id__"),
          completion(isNull),
        );
      });

      test(
          "returns content when article exists "
          "and preview is false", () {
        final item = healthItems.first;
        expect(
          feedDataSource.getArticle(id: item.post.id),
          completion(
            articleHaving(
              blocks: item.content,
              totalBlocks: item.content.length,
            ),
          ),
        );
      });

      test(
          "returns content preview when article exists "
          "and preview is true", () {
        final item = healthItems.first;
        expect(
          feedDataSource.getArticle(id: item.post.id, preview: true),
          completion(
            articleHaving(
              blocks: item.contentPreview,
              totalBlocks: item.contentPreview.length,
            ),
          ),
        );
      });

      test("supports limit if specified", () {
        final item = healthItems.first;
        expect(
          feedDataSource.getArticle(id: item.post.id, limit: 1),
          completion(
            articleHaving(
              blocks: item.content.take(1).toList(),
              totalBlocks: item.content.length,
            ),
          ),
        );
      });

      test("supports offset if specified", () {
        final item = healthItems.first;
        expect(
          feedDataSource.getArticle(id: item.post.id, offset: 1),
          completion(
            articleHaving(
              blocks: item.content.sublist(1).toList(),
              totalBlocks: item.content.length,
            ),
          ),
        );
      });
    });

    group("isPremiumArticle", () {
      test("returns null when article id cannot be found", () {
        expect(
          feedDataSource.isPremiumArticle(id: "__invalid_article_id__"),
          completion(isNull),
        );
      });

      test(
          "returns true when article exists "
          "and isPremium is true", () {
        final item = technologySmallItems.last;
        expect(
          feedDataSource.isPremiumArticle(id: item.post.id),
          completion(isTrue),
        );
      });

      test(
          "returns false when article exists "
          "and isPremium is false", () {
        final item = healthItems.last;
        expect(
          feedDataSource.isPremiumArticle(id: item.post.id),
          completion(isFalse),
        );
      });
    });

    group("getPopularArticles", () {
      test("returns correct list of articles", () async {
        expect(
          feedDataSource.getPopularArticles(),
          completion(equals(popularArticles.map((item) => item.post).toList())),
        );
      });
    });

    group("getPopularTopics", () {
      test("returns correct list of topics", () async {
        expect(
          feedDataSource.getPopularTopics(),
          completion(equals(popularTopics)),
        );
      });
    });

    group("getRelevantArticles", () {
      test("returns correct list of articles", () async {
        expect(
          feedDataSource.getRelevantArticles(term: "term"),
          completion(
            equals(relevantArticles.map((item) => item.post).toList()),
          ),
        );
      });
    });

    group("getRelevantTopics", () {
      test("returns correct list of topics", () async {
        expect(
          feedDataSource.getRelevantTopics(term: "term"),
          completion(equals(relevantTopics)),
        );
      });
    });

    group("getRelatedArticles", () {
      test("returns empty when article id cannot be found", () {
        expect(
          feedDataSource.getRelatedArticles(id: "__invalid_article_id__"),
          completion(equals(RelatedArticles.empty())),
        );
      });

      test("returns null when related articles cannot be found", () {
        expect(
          feedDataSource.getRelatedArticles(id: scienceVideoItems.last.post.id),
          completion(equals(RelatedArticles.empty())),
        );
      });

      test("returns related articles when article exists", () {
        final item = healthItems.first;
        final relatedArticles = item.relatedArticles;
        expect(
          feedDataSource.getRelatedArticles(id: item.post.id),
          completion(
            relatedArticlesHaving(
              blocks: relatedArticles,
              totalBlocks: relatedArticles.length,
            ),
          ),
        );
      });

      test("supports limit if specified", () {
        final item = healthItems.first;
        final relatedArticles = item.relatedArticles;
        expect(
          feedDataSource.getRelatedArticles(id: item.post.id, limit: 1),
          completion(
            relatedArticlesHaving(
              blocks: relatedArticles.take(1).toList(),
              totalBlocks: relatedArticles.length,
            ),
          ),
        );
      });

      test("supports offset if specified", () {
        final item = healthSmallItems.first;
        final relatedArticles = item.relatedArticles;
        expect(
          feedDataSource.getRelatedArticles(id: item.post.id, offset: 1),
          completion(
            relatedArticlesHaving(
              blocks: relatedArticles.sublist(1).toList(),
              totalBlocks: relatedArticles.length,
            ),
          ),
        );
      });
    });
  });
}

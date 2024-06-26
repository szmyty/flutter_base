// ignore_for_file: unnecessary_const, prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:feed_blocks_ui/feed_blocks_ui.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail_image_network/mocktail_image_network.dart";

import "../helpers/helpers.dart";

void main() {
  group("TrendingStory", () {
    setUpAll(() {
      setUpTolerantComparator();
      setUpMockPathProvider();
    });

    testWidgets("renders correctly", (tester) async {
      await mockNetworkImages(() async {
        final widget = TrendingStory(
          title: "TRENDING",
          block: TrendingStoryBlock(
            content: PostSmallBlock(
              id: "id",
              category: PostCategory.technology,
              author: "author",
              publishedAt: DateTime(2022, 3, 11),
              imageUrl: "imageUrl",
              title: "title",
            ),
          ),
        );

        await tester.pumpApp(widget);

        await expectLater(
          find.byType(TrendingStory),
          matchesGoldenFile("trending_story.png"),
        );
      });
    });
  });
}

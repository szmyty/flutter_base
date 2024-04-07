// ignore_for_file: prefer_const_constructors

import "package:app_api/api.dart";
import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("Feed", () {
    test("can be (de)serialized", () {
      final sectionHeaderA = SectionHeaderBlock(title: "sectionA");
      final sectionHeaderB = SectionHeaderBlock(title: "sectionB");
      final feed = Feed(
        blocks: [sectionHeaderA, sectionHeaderB],
        totalBlocks: 2,
      );

      expect(Feed.fromJson(feed.toJson()), equals(feed));
    });
  });
}

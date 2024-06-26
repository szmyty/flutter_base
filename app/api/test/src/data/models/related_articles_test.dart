// ignore_for_file: prefer_const_constructors

import "package:app_api/api.dart";
import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("RelatedArticles", () {
    test("can be (de)serialized", () {
      final blockA = SectionHeaderBlock(title: "sectionA");
      final blockB = SectionHeaderBlock(title: "sectionB");
      final relatedArticles = RelatedArticles(
        blocks: [blockA, blockB],
        totalBlocks: 2,
      );

      expect(
        RelatedArticles.fromJson(relatedArticles.toJson()),
        equals(relatedArticles),
      );
    });
  });
}

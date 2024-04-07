// ignore_for_file: prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("FeedBlocksConverter", () {
    test("can (de)serialize List<FeedBlock>", () {
      final converter = FeedBlocksConverter();
      final newsBlocks = <FeedBlock>[
        SectionHeaderBlock(title: "title"),
        DividerHorizontalBlock(),
        SpacerBlock(spacing: Spacing.medium),
        PostSmallBlock(
          id: "id",
          category: PostCategory.health,
          author: "author",
          publishedAt: DateTime(2022, 3, 11),
          imageUrl: "imageUrl",
          title: "title",
          description: "description",
        ),
      ];

      expect(
        converter.fromJson(converter.toJson(newsBlocks)),
        equals(newsBlocks),
      );
    });
  });
}

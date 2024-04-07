// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, lines_longer_than_80_chars

import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

class CustomBlock extends FeedBlock {
  CustomBlock({super.type = "__custom_block__"});

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{"type": type};
}

void main() {
  group("FeedBlock", () {
    test("can be extended", () {
      expect(CustomBlock.new, returnsNormally);
    });

    group("fromJson", () {
      test("returns UnknownBlock when type is missing", () {
        expect(FeedBlock.fromJson(<String, dynamic>{}), equals(UnknownBlock()));
      });

      test("returns UnknownBlock when type is unrecognized", () {
        expect(
          FeedBlock.fromJson(<String, dynamic>{"type": "unrecognized"}),
          equals(UnknownBlock()),
        );
      });

      test("returns SectionHeaderBlock", () {
        final block = SectionHeaderBlock(title: "Example");
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns DividerHorizontalBlock", () {
        final block = DividerHorizontalBlock();
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns SpacerBlock", () {
        final block = SpacerBlock(spacing: Spacing.medium);
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns TextCaptionBlock", () {
        final block = TextCaptionBlock(
          text: "Text caption",
          color: TextCaptionColor.light,
        );
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns TextHeadlineBlock", () {
        final block = TextHeadlineBlock(text: "Text Headline");
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns TextLeadParagraphBlock", () {
        final block = TextLeadParagraphBlock(text: "Text Lead Paragraph");
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns TextParagraphBlock", () {
        final block = TextParagraphBlock(text: "Text Paragraph");
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns ImageBlock", () {
        final block = ImageBlock(imageUrl: "imageUrl");
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns VideoBlock", () {
        final block = VideoBlock(videoUrl: "videoUrl");
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns VideoIntroductionBlock", () {
        final block = VideoIntroductionBlock(
          category: PostCategory.technology,
          title: "title",
          videoUrl: "videoUrl",
        );
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns ArticleIntroductionBlock", () {
        final block = ArticleIntroductionBlock(
          category: PostCategory.technology,
          author: "author",
          publishedAt: DateTime(2022, 3, 9),
          imageUrl: "imageUrl",
          title: "title",
        );
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns PostLargeBlock", () {
        final block = PostLargeBlock(
          id: "id",
          category: PostCategory.technology,
          author: "author",
          publishedAt: DateTime(2022, 3, 9),
          imageUrl: "imageUrl",
          title: "title",
        );

        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns PostMediumBlock", () {
        final block = PostMediumBlock(
          id: "id",
          category: PostCategory.sports,
          author: "author",
          publishedAt: DateTime(2022, 3, 10),
          imageUrl: "imageUrl",
          title: "title",
        );

        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns PostSmallBlock", () {
        final block = PostSmallBlock(
          id: "id",
          category: PostCategory.health,
          author: "author",
          publishedAt: DateTime(2022, 3, 11),
          imageUrl: "imageUrl",
          title: "title",
        );

        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns PostGridGroupBlock", () {
        final block = PostGridGroupBlock(
          category: PostCategory.science,
          tiles: [
            PostGridTileBlock(
              id: "id",
              category: PostCategory.science,
              author: "author",
              publishedAt: DateTime(2022, 3, 12),
              imageUrl: "imageUrl",
              title: "title",
            ),
          ],
        );

        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns PostGridTileBlock", () {
        final block = PostGridTileBlock(
          id: "id",
          category: PostCategory.science,
          author: "author",
          publishedAt: DateTime(2022, 3, 12),
          imageUrl: "imageUrl",
          title: "title",
        );

        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns NewsletterBlock", () {
        final block = NewsletterBlock();

        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns BannerAdBlock", () {
        final block = BannerAdBlock(
          size: BannerAdSize.normal,
        );
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns HtmlBlock", () {
        final block = HtmlBlock(content: "<p>hello</p>");
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns SlideBlock", () {
        final block = SlideBlock(
          imageUrl: "imageUrl",
          caption: "caption",
          photoCredit: "photoCredit",
          description: "description",
        );
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns SlideshowBlock", () {
        final slide = SlideBlock(
          imageUrl: "imageUrl",
          caption: "caption",
          photoCredit: "photoCredit",
          description: "description",
        );
        final block = SlideshowBlock(title: "title", slides: [slide]);
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns SlideshowIntroductionBlock", () {
        final block = SlideshowIntroductionBlock(
          title: "title",
          coverImageUrl: "coverImageUrl",
        );
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });

      test("returns TrendingStoryBlock", () {
        final content = PostSmallBlock(
          id: "id",
          category: PostCategory.health,
          author: "author",
          publishedAt: DateTime(2022, 3, 11),
          imageUrl: "imageUrl",
          title: "title",
        );
        final block = TrendingStoryBlock(content: content);
        expect(FeedBlock.fromJson(block.toJson()), equals(block));
      });
    });
  });
}

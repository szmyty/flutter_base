// ignore_for_file: prefer_const_constructors
import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("SlideshowIntroductionBlock", () {
    test("can be (de)serialized", () {
      final block = SlideshowIntroductionBlock(
        title: "title",
        coverImageUrl: "coverImageUrl",
      );

      expect(
        SlideshowIntroductionBlock.fromJson(block.toJson()),
        equals(block),
      );
    });
  });
}

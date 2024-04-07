// ignore_for_file: prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("SpacerBlock", () {
    test("can be (de)serialized", () {
      final block = SpacerBlock(spacing: Spacing.medium);

      expect(SpacerBlock.fromJson(block.toJson()), equals(block));
    });
  });
}

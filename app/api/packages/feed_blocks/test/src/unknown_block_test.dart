// ignore_for_file: prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("UnknownBlock", () {
    test("can be (de)serialized", () {
      final block = UnknownBlock();
      expect(UnknownBlock.fromJson(block.toJson()), equals(block));
    });
  });
}

// ignore_for_file: prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("HtmlBlock", () {
    test("can be (de)serialized", () {
      final block = HtmlBlock(content: "<p>hello world</p>");

      expect(HtmlBlock.fromJson(block.toJson()), equals(block));
    });
  });
}

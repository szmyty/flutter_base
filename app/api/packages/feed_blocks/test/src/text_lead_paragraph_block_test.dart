// ignore_for_file: prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:test/test.dart";

void main() {
  group("TextLeadParagraphBlock", () {
    test("can be (de)serialized", () {
      final block = TextLeadParagraphBlock(text: "Text Lead Paragraph");

      expect(TextLeadParagraphBlock.fromJson(block.toJson()), equals(block));
    });
  });
}

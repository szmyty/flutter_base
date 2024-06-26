// ignore_for_file: unnecessary_const, prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:feed_blocks_ui/feed_blocks_ui.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../helpers/helpers.dart";

void main() {
  group("TextLeadParagraph", () {
    setUpAll(setUpTolerantComparator);

    testWidgets("renders correctly", (tester) async {
      final widget = Center(
        child: TextLeadParagraph(
          block: TextLeadParagraphBlock(text: "Text Lead Paragraph"),
        ),
      );

      await tester.pumpApp(widget);

      await expectLater(
        find.byType(TextLeadParagraph),
        matchesGoldenFile("text_lead_paragraph.png"),
      );
    });
  });
}

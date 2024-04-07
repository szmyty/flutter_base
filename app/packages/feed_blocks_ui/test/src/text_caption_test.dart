// ignore_for_file: unnecessary_const, prefer_const_constructors

import "package:feed_blocks_ui/feed_blocks_ui.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:feed_blocks/feed_blocks.dart";

import "../helpers/helpers.dart";

void main() {
  group("TextCaption", () {
    setUpAll(setUpTolerantComparator);

    testWidgets(
        "renders correctly "
        "with default normal color", (tester) async {
      final widget = Center(
        child: TextCaption(
          block: TextCaptionBlock(
            text: "Text caption",
            color: TextCaptionColor.normal,
          ),
        ),
      );

      await tester.pumpApp(widget);

      await expectLater(
        find.byType(TextCaption),
        matchesGoldenFile("text_caption_normal_color_default.png"),
      );
    });

    testWidgets(
        "renders correctly "
        "with default light color", (tester) async {
      final widget = Center(
        child: TextCaption(
          block: TextCaptionBlock(
            text: "Text caption",
            color: TextCaptionColor.light,
          ),
        ),
      );

      await tester.pumpApp(widget);

      await expectLater(
        find.byType(TextCaption),
        matchesGoldenFile("text_caption_light_color_default.png"),
      );
    });

    testWidgets(
        "renders correctly "
        "with provided normal color", (tester) async {
      final widget = Center(
        child: TextCaption(
          block: TextCaptionBlock(
            text: "Text caption",
            color: TextCaptionColor.normal,
          ),
          colorValues: const {
            TextCaptionColor.normal: Colors.green,
          },
        ),
      );

      await tester.pumpApp(widget);

      await expectLater(
        find.byType(TextCaption),
        matchesGoldenFile("text_caption_normal_color_provided.png"),
      );
    });

    testWidgets(
        "renders correctly "
        "with provided light color", (tester) async {
      final widget = Center(
        child: TextCaption(
          block: TextCaptionBlock(
            text: "Text caption",
            color: TextCaptionColor.light,
          ),
          colorValues: const {
            TextCaptionColor.light: Colors.green,
          },
        ),
      );

      await tester.pumpApp(widget);

      await expectLater(
        find.byType(TextCaption),
        matchesGoldenFile("text_caption_light_color_provided.png"),
      );
    });
  });
}

// ignore_for_file: unnecessary_const, prefer_const_constructors

import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:news_blocks/news_blocks.dart";
import "package:feed_blocks_ui/feed_blocks_ui.dart";

import "../helpers/helpers.dart";

void main() {
  group("DividerHorizontal", () {
    setUpAll(setUpTolerantComparator);

    testWidgets("renders correctly", (tester) async {
      final widget = Center(
        child: DividerHorizontal(
          block: DividerHorizontalBlock(),
        ),
      );

      await tester.pumpApp(widget);

      await expectLater(
        find.byType(DividerHorizontal),
        matchesGoldenFile("divider_horizontal.png"),
      );
    });
  });
}
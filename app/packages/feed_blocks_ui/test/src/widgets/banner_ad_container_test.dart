// ignore_for_file: prefer_const_constructors

import "package:feed_blocks/feed_blocks.dart";
import "package:feed_blocks_ui/src/widgets/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/helpers.dart";

void main() {
  group("BannerAdContainer", () {
    testWidgets("renders ColoredBox", (tester) async {
      await tester.pumpApp(
        BannerAdContainer(
          size: BannerAdSize.normal,
          child: SizedBox(),
        ),
      );

      expect(find.byKey(Key("bannerAdContainer_coloredBox")), findsOneWidget);
    });

    testWidgets("renders child", (tester) async {
      const childKey = Key("__child__");

      await tester.pumpApp(
        BannerAdContainer(
          size: BannerAdSize.large,
          child: SizedBox(key: childKey),
        ),
      );

      expect(find.byKey(childKey), findsOneWidget);
    });
  });
}

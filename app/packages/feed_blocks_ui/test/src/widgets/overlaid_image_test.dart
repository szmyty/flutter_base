// ignore_for_file: prefer_const_constructors

import "package:feed_blocks_ui/src/widgets/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail_image_network/mocktail_image_network.dart";

import "../../helpers/helpers.dart";

void main() {
  group("OverlaidImage", () {
    testWidgets("renders correctly", (tester) async {
      final overlaidImage = OverlaidImage(
        imageUrl: "url",
        gradientColor: Colors.black,
      );

      await mockNetworkImages(
        () async => tester.pumpContentThemedApp(overlaidImage),
      );

      expect(
        find.byKey(const Key("overlaidImage_stack")),
        findsOneWidget,
      );
    });
  });
}

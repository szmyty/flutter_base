// ignore_for_file: prefer_const_constructors
import "package:feed_blocks_ui/src/widgets/widgets.dart";
import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers/helpers.dart";

void main() {
  group("LockIcon", () {
    testWidgets("renders correctly", (tester) async {
      await tester.pumpApp(LockIcon());

      expect(find.byType(Icon), findsOneWidget);
    });
  });
}

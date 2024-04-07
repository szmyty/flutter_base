import "package:flutter/material.dart";
import "package:feed_blocks/feed_blocks.dart";

/// {@template divider_horizontal}
/// A reusable divider horizontal block widget.
/// {@endtemplate}
class DividerHorizontal extends StatelessWidget {
  /// {@macro divider_horizontal}
  const DividerHorizontal({required this.block, super.key});

  /// The associated [DividerHorizontalBlock] instance.
  final DividerHorizontalBlock block;

  @override
  Widget build(BuildContext context) => const Divider();
}

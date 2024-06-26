import "package:app_ui/app_ui.dart";
import "package:feed_blocks/feed_blocks.dart";
import "package:flutter/material.dart";

/// {@template text_paragraph}
/// A reusable text paragraph block widget.
/// {@endtemplate}
class TextParagraph extends StatelessWidget {
  /// {@macro text_paragraph}
  const TextParagraph({required this.block, super.key});

  /// The associated [TextParagraphBlock] instance.
  final TextParagraphBlock block;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Text(
        block.text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

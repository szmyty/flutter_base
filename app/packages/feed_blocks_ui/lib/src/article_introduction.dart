import "package:app_ui/app_ui.dart";
import "package:feed_blocks/feed_blocks.dart";
import "package:feed_blocks_ui/src/widgets/widgets.dart";
import "package:flutter/material.dart";

/// {@template article_introduction}
/// A reusable article introduction block widget.
/// {@endtemplate}
class ArticleIntroduction extends StatelessWidget {
  /// {@macro article_introduction}
  const ArticleIntroduction({
    required this.block,
    required this.premiumText,
    super.key,
  });

  /// The associated [ArticleIntroductionBlock] instance.
  final ArticleIntroductionBlock block;

  /// Text displayed when article is premium content.
  final String premiumText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (block.imageUrl != null) InlineImage(imageUrl: block.imageUrl!),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: PostContent(
            categoryName: block.category.name,
            title: block.title,
            author: block.author,
            publishedAt: block.publishedAt,
            premiumText: premiumText,
            isPremium: block.isPremium,
          ),
        ),
        const Divider(),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

import "package:app/app/bloc/app_bloc.dart";
import "package:app/categories/categories.dart";
import "package:feed_blocks_ui/feed_blocks_ui.dart";
import "package:flutter/material.dart" hide Spacer;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:feed_blocks/feed_blocks.dart";

class CategoryFeedItem extends StatelessWidget {
  const CategoryFeedItem({required this.block, super.key});

  /// The associated [NewsBlock] instance.
  final NewsBlock block;

  @override
  Widget build(BuildContext context) {
    final newsBlock = block;

    final isUserSubscribed =
        context.select((AppBloc bloc) => bloc.state.isUserSubscribed);

    late Widget widget;

    if (newsBlock is DividerHorizontalBlock) {
      widget = DividerHorizontal(block: newsBlock);
    } else if (newsBlock is SpacerBlock) {
      widget = Spacer(block: newsBlock);
    } else if (newsBlock is SectionHeaderBlock) {
      widget = SectionHeader(
        block: newsBlock,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (newsBlock is PostLargeBlock) {
      widget = PostLarge(
        block: newsBlock,
        premiumText: "Premium",
        isLocked: newsBlock.isPremium && !isUserSubscribed,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (newsBlock is PostMediumBlock) {
      widget = PostMedium(
        block: newsBlock,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (newsBlock is PostSmallBlock) {
      widget = PostSmall(
        block: newsBlock,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (newsBlock is PostGridGroupBlock) {
      widget = PostGrid(
        gridGroupBlock: newsBlock,
        premiumText: "Premium",
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (newsBlock is NewsletterBlock) {
      widget = const Newsletter();
    } else if (newsBlock is BannerAdBlock) {
      widget = BannerAd(
        block: newsBlock,
        adFailedToLoadTitle: "Ad failed to load",
      );
    } else {
      // Render an empty widget for the unsupported block type.
      widget = const SizedBox();
    }

    return (newsBlock is! PostGridGroupBlock)
        ? SliverToBoxAdapter(child: widget)
        : widget;
  }

  /// Handles actions triggered by tapping on feed items.
  Future<void> _onFeedItemAction(
    BuildContext context,
    BlockAction action,
  ) async {
    if (action is NavigateToArticleAction) {
      await Navigator.of(context).push<void>(
        ArticlePage.route(id: action.articleId),
      );
    } else if (action is NavigateToVideoArticleAction) {
      await Navigator.of(context).push<void>(
        ArticlePage.route(id: action.articleId, isVideoArticle: true),
      );
    } else if (action is NavigateToFeedCategoryAction) {
      context
          .read<CategoriesBloc>()
          .add(CategorySelected(category: action.category));
    }
  }
}

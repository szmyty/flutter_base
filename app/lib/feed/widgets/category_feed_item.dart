import "package:app/app/bloc/app_bloc.dart";
import "package:app/categories/categories.dart";
import "package:feed_blocks/feed_blocks.dart";
import "package:feed_blocks_ui/feed_blocks_ui.dart";
import "package:flutter/material.dart" hide Spacer;
import "package:flutter_bloc/flutter_bloc.dart";

class CategoryFeedItem extends StatelessWidget {
  const CategoryFeedItem({required this.block, super.key});

  /// The associated [feedBlock] instance.
  final FeedBlock block;

  @override
  Widget build(BuildContext context) {
    final feedBlock = block;

    final isUserSubscribed =
        context.select((AppBloc bloc) => bloc.state.isUserSubscribed);

    late Widget widget;

    if (feedBlock is DividerHorizontalBlock) {
      widget = DividerHorizontal(block: feedBlock);
    } else if (feedBlock is SpacerBlock) {
      widget = Spacer(block: feedBlock);
    } else if (feedBlock is SectionHeaderBlock) {
      widget = SectionHeader(
        block: feedBlock,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (feedBlock is PostLargeBlock) {
      widget = PostLarge(
        block: feedBlock,
        premiumText: "Premium",
        isLocked: feedBlock.isPremium && !isUserSubscribed,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (feedBlock is PostMediumBlock) {
      widget = PostMedium(
        block: feedBlock,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (feedBlock is PostSmallBlock) {
      widget = PostSmall(
        block: feedBlock,
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (feedBlock is PostGridGroupBlock) {
      widget = PostGrid(
        gridGroupBlock: feedBlock,
        premiumText: "Premium",
        onPressed: (action) => _onFeedItemAction(context, action),
      );
    } else if (feedBlock is NewsletterBlock) {
      widget = const Newsletter();
    } else if (feedBlock is BannerAdBlock) {
      widget = BannerAd(
        block: feedBlock,
        adFailedToLoadTitle: "Ad failed to load",
      );
    } else {
      // Render an empty widget for the unsupported block type.
      widget = const SizedBox();
    }

    return (feedBlock is! PostGridGroupBlock)
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

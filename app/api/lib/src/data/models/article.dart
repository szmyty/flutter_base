import "package:equatable/equatable.dart";
import "package:json_annotation/json_annotation.dart";
import "package:feed_blocks/feed_blocks.dart";

part "article.g.dart";

/// {@template article}
/// An article object which contains paginated contents.
/// {@endtemplate}
@JsonSerializable()
class Article extends Equatable {
  /// {@macro article}
  const Article({
    required this.title,
    required this.blocks,
    required this.totalBlocks,
    required this.url,
  });

  /// Converts a `Map<String, dynamic>` into a [Article] instance.
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  /// The article title.
  final String title;

  /// The list of feed blocks for the associated article (paginated).
  @FeedBlocksConverter()
  final List<FeedBlock> blocks;

  /// The total number of blocks for this article.
  final int totalBlocks;

  /// The article url.
  final Uri url;

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  List<Object> get props => [title, blocks, totalBlocks, url];
}

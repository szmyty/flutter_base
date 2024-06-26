import "package:equatable/equatable.dart";
import "package:feed_blocks/feed_blocks.dart";
import "package:json_annotation/json_annotation.dart";

part "feed.g.dart";

/// {@template feed}
/// A news feed object which contains paginated news feed metadata.
/// {@endtemplate}
@JsonSerializable()
class Feed extends Equatable {
  /// {@macro feed}
  const Feed({required this.blocks, required this.totalBlocks});

  /// Converts a `Map<String, dynamic>` into a [Feed] instance.
  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

  /// The list of news blocks for the associated feed (paginated).
  @FeedBlockConverter()
  final List<FeedBlock> blocks;

  /// The total number of blocks for this feed.
  final int totalBlocks;

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$FeedToJson(this);

  @override
  List<Object> get props => [blocks, totalBlocks];
}

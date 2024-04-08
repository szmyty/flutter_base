import "package:feed_blocks/feed_blocks.dart";
import "package:json_annotation/json_annotation.dart";

/// {@template feed_blocks_converter}
/// A [JsonConverter] that supports (de)serializing a `List<FeedBlock>`.
/// {@endtemplate}
class FeedBlocksConverter
    implements JsonConverter<List<FeedBlock>, List<dynamic>> {
  /// {@macro feed_blocks_converter}
  const FeedBlocksConverter();

  @override
  List<Map<String, dynamic>> toJson(List<FeedBlock> blocks) {
    return blocks.map((b) => b.toJson()).toList();
  }

  @override
  List<FeedBlock> fromJson(List<dynamic> jsonString) {
    return jsonString
        .map((dynamic e) => FeedBlock.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

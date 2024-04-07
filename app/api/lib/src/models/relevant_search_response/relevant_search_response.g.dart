// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relevant_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelevantSearchResponse _$RelevantSearchResponseFromJson(
        Map<String, dynamic> json) =>
    RelevantSearchResponse(
      articles: const FeedBlocksConverter().fromJson(json['articles'] as List),
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RelevantSearchResponseToJson(
        RelevantSearchResponse instance) =>
    <String, dynamic>{
      'articles': const FeedBlocksConverter().toJson(instance.articles),
      'topics': instance.topics,
    };

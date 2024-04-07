// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedResponse _$FeedResponseFromJson(Map<String, dynamic> json) => FeedResponse(
      feed: const FeedBlocksConverter().fromJson(json['feed'] as List),
      totalCount: json['totalCount'] as int,
    );

Map<String, dynamic> _$FeedResponseToJson(FeedResponse instance) =>
    <String, dynamic>{
      'feed': const FeedBlocksConverter().toJson(instance.feed),
      'totalCount': instance.totalCount,
    };

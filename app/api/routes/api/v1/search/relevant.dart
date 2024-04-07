import "dart:io";

import "package:app_api/api.dart";
import "package:dart_frog/dart_frog.dart";
import "package:feed_blocks/feed_blocks.dart";

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  final term = context.request.url.queryParameters["q"];
  if (term == null) return Response(statusCode: HttpStatus.badRequest);

  final newsDataSource = context.read<FeedDataSource>();
  final results = await Future.wait([
    newsDataSource.getRelevantArticles(term: term),
    newsDataSource.getRelevantTopics(term: term),
  ]);
  final articles = results.first as List<FeedBlock>;
  final topics = results.last as List<String>;
  final response = RelevantSearchResponse(articles: articles, topics: topics);
  return Response.json(body: response);
}

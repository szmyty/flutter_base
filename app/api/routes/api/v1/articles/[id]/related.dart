import "dart:io";

import "package:app_api/api.dart";
import "package:dart_frog/dart_frog.dart";

Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  final queryParams = context.request.url.queryParameters;
  final limit = int.tryParse(queryParams["limit"] ?? "") ?? 20;
  final offset = int.tryParse(queryParams["offset"] ?? "") ?? 0;
  final relatedArticles = await context
      .read<FeedDataSource>()
      .getRelatedArticles(id: id, limit: limit, offset: offset);
  final response = RelatedArticlesResponse(
    relatedArticles: relatedArticles.blocks,
    totalCount: relatedArticles.totalBlocks,
  );
  return Response.json(body: response);
}

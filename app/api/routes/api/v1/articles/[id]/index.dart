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
  final previewRequested = queryParams["preview"] == "true";
  final feedDataSource = context.read<FeedDataSource>();
  final isPremium = await feedDataSource.isPremiumArticle(id: id);

  if (isPremium == null) return Response(statusCode: HttpStatus.notFound);

  Future<bool> shouldShowFullArticle() async {
    if (previewRequested) return false;
    if (!isPremium) return true;
    final requestUser = context.read<RequestUser>();
    if (isPremium && requestUser.isAnonymous) return false;
    final user = await feedDataSource.getUser(userId: requestUser.id);
    if (user == null) return false;
    if (user.subscription == SubscriptionPlan.none) return false;
    return true;
  }

  final showFullArticle = await shouldShowFullArticle();
  final article = await feedDataSource.getArticle(
    id: id,
    limit: limit,
    offset: offset,
    preview: !showFullArticle,
  );

  if (article == null) return Response(statusCode: HttpStatus.notFound);
  final response = ArticleResponse(
    title: article.title,
    content: article.blocks,
    totalCount: article.totalBlocks,
    url: article.url,
    isPremium: isPremium,
    isPreview: !showFullArticle,
  );
  return Response.json(body: response);
}

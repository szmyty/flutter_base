import "dart:io";

import "package:app_api/api.dart";
import "package:dart_frog/dart_frog.dart";

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) return _onPostRequest(context);
  if (context.request.method == HttpMethod.get) return _onGetRequest(context);

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _onPostRequest(RequestContext context) async {
  final subscriptionId = context.request.url.queryParameters["subscriptionId"];
  final user = context.read<RequestUser>();

  if (user.isAnonymous || subscriptionId == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  await context.read<FeedDataSource>().createSubscription(
        userId: user.id,
        subscriptionId: subscriptionId,
      );

  return Response(statusCode: HttpStatus.created);
}

Future<Response> _onGetRequest(RequestContext context) async {
  final subscriptions = await context.read<FeedDataSource>().getSubscriptions();
  final response = SubscriptionsResponse(subscriptions: subscriptions);
  return Response.json(body: response);
}

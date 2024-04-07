import "dart:async";

import "package:app_api/client.dart" hide User;
import "package:authentication_client/authentication_client.dart";
import "package:equatable/equatable.dart";
import "package:package_info_client/package_info_client.dart";
import "package:rxdart/rxdart.dart";
import "package:storage/storage.dart";
import "package:user_repository/user_repository.dart";

part "user_storage.dart";

/// {@template user_failure}
/// A base failure for the user repository failures.
/// {@endtemplate}
abstract class UserFailure with EquatableMixin implements Exception {
  /// {@macro user_failure}
  const UserFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template fetch_app_opened_count_failure}
/// Thrown when fetching app opened count fails.
/// {@endtemplate}
class FetchAppOpenedCountFailure extends UserFailure {
  /// {@macro fetch_app_opened_count_failure}
  const FetchAppOpenedCountFailure(super.error);
}

/// {@template increment_app_opened_count_failure}
/// Thrown when incrementing app opened count fails.
/// {@endtemplate}
class IncrementAppOpenedCountFailure extends UserFailure {
  /// {@macro increment_app_opened_count_failure}
  const IncrementAppOpenedCountFailure(super.error);
}

/// {@template fetch_current_subscription_failure}
/// An exception thrown when fetching current subscription fails.
/// {@endtemplate}
class FetchCurrentSubscriptionFailure extends UserFailure {
  /// {@macro fetch_current_subscription_failure}
  const FetchCurrentSubscriptionFailure(super.error);
}

/// {@template user_repository}
/// Repository which manages the user domain.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required ApiClient apiClient,
    required AuthenticationClient authenticationClient,
    required PackageInfoClient packageInfoClient,
    // required DeepLinkClient deepLinkClient,
    required UserStorage storage,
  })  : _apiClient = apiClient,
        _authenticationClient = authenticationClient,
        _packageInfoClient = packageInfoClient,
        // _deepLinkClient = deepLinkClient,
        _storage = storage;

  final ApiClient _apiClient;
  final AuthenticationClient _authenticationClient;
  final PackageInfoClient _packageInfoClient;
//   final DeepLinkClient _deepLinkClient;
  final UserStorage _storage;

  /// Stream of [User] which will emit the current user when
  /// the authentication state or the subscription plan changes.
  ///
  Stream<User> get user =>
      Rx.combineLatest2<AuthenticationUser, SubscriptionPlan, User>(
        _authenticationClient.user,
        _currentSubscriptionPlanSubject.stream,
        (authenticationUser, subscriptionPlan) => User.fromAuthenticationUser(
          authenticationUser: authenticationUser,
          subscriptionPlan: authenticationUser != AuthenticationUser.anonymous
              ? subscriptionPlan
              : SubscriptionPlan.none,
        ),
      ).asBroadcastStream();

  final BehaviorSubject<SubscriptionPlan> _currentSubscriptionPlanSubject =
      BehaviorSubject.seeded(SubscriptionPlan.none);

  /// A stream of incoming email links used to authenticate the user.
  ///
  /// Emits when a new email link is emitted on [DeepLinkClient.deepLinkStream],
  /// which is validated using [AuthenticationClient.isLogInWithEmailLink].
//   Stream<Uri> get incomingEmailLinks => _deepLinkClient.deepLinkStream.where(
//         (deepLink) => _authenticationClient.isLogInWithEmailLink(
//           emailLink: deepLink.toString(),
//         ),
//       );

  /// Sends an authentication link to the provided [email].
  ///
  /// Throws a [SendLoginEmailLinkFailure] if an exception occurs.
  Future<void> sendLoginEmailLink({
    required String email,
  }) async {
    try {
      await _authenticationClient.sendLoginEmailLink(
        email: email,
        appPackageName: _packageInfoClient.packageName,
      );
    } on SendLoginEmailLinkFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SendLoginEmailLinkFailure(error), stackTrace);
    }
  }

  /// Signs in with the provided [email] and [emailLink].
  ///
  /// Throws a [LogInWithEmailLinkFailure] if an exception occurs.
  Future<void> logInWithEmailLink({
    required String email,
    required String emailLink,
  }) async {
    try {
      await _authenticationClient.logInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
    } on LogInWithEmailLinkFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithEmailLinkFailure(error), stackTrace);
    }
  }

  /// Signs out the current user which will emit
  /// [User.anonymous] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
    } on LogOutFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  /// Deletes the current user account.
  Future<void> deleteAccount() async {
    try {
      await _authenticationClient.deleteAccount();
    } on DeleteAccountFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(DeleteAccountFailure(error), stackTrace);
    }
  }

  /// Returns the number of times the app was opened.
  Future<int> fetchAppOpenedCount() async {
    try {
      return await _storage.fetchAppOpenedCount();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        FetchAppOpenedCountFailure(error),
        stackTrace,
      );
    }
  }

  /// Increments the number of times the app was opened by 1.
  Future<void> incrementAppOpenedCount() async {
    try {
      final value = await fetchAppOpenedCount();
      final result = value + 1;
      await _storage.setAppOpenedCount(count: result);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        IncrementAppOpenedCountFailure(error),
        stackTrace,
      );
    }
  }

  /// Updates the current subscription plan of the user.
  Future<void> updateSubscriptionPlan() async {
    try {
      final response = await _apiClient.getCurrentUser();
      _currentSubscriptionPlanSubject.add(response.user.subscription);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        FetchCurrentSubscriptionFailure(error),
        stackTrace,
      );
    }
  }
}

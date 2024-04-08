part of "app_bloc.dart";

/// Enumeration representing the current status of the application.
enum AppStatus {
    /// The user is required to go through the onboarding process.
    ///
    /// This status indicates that the user is new or needs to complete certain
    /// setup steps before accessing the main features of the application.
    onboardingRequired(),

    /// The user is authenticated and has access to the main features of the
    /// application.
    ///
    /// This status indicates that the user has successfully logged in or
    /// completed the onboarding process and can use the application's features.
    authenticated(),

    /// The user is not authenticated and has limited access to the application.
    ///
    /// This status indicates that the user is not logged in and may need to
    /// authenticate or register to access certain features of the application.
    unauthenticated();

    /// Determines if the user is logged in based on the current app status.
    bool get isLoggedIn =>
        this == AppStatus.authenticated || this == AppStatus.onboardingRequired;
}

/// Represents the state of the application.
///
/// [AppState] contains information about the current status of the
/// application, the authenticated user (if any), and whether a login
/// overlay should be displayed.
class AppState extends Equatable {
  /// Constructs an instance of [AppState].
  const AppState({
    required this.status,
    this.user = User.anonymous,
    this.showLoginOverlay = false,
  });

  /// Constructs an instance of [AppState] representing an authenticated state.
  const AppState.authenticated(
    User user,
  ) : this(
          status: AppStatus.authenticated,
          user: user,
        );

  /// Constructs an instance of [AppState] representing a state where onboarding
  /// is required.
  const AppState.onboardingRequired(User user)
      : this(
          status: AppStatus.onboardingRequired,
          user: user,
        );

 /// Constructs an instance of [AppState] representing an unauthenticated state.
  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated);

  /// The current status of the application.
  final AppStatus status;

  /// The authenticated user. Defaults to [User.anonymous] if not provided.
  final User user;

  /// Indicates whether a login overlay should be displayed.
  final bool showLoginOverlay;

  /// Returns `true` if the user is subscribed; otherwise, returns `false`.
  ///
  /// TODO(me): This is a placeholder method. The actual implementation should
  /// check the subscription status of the user.
  bool get isUserSubscribed => true;

  @override
  List<Object?> get props => [
        status,
        user,
        showLoginOverlay,
        isUserSubscribed,
      ];

  /// Creates a copy of this [AppState] with the given fields replaced
  /// with the new values.
  AppState copyWith({
    AppStatus? status,
    User? user,
    bool? showLoginOverlay,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      showLoginOverlay: showLoginOverlay ?? this.showLoginOverlay,
    );
  }
}

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

class AppState extends Equatable {
  const AppState({
    required this.status,
    this.user = User.anonymous,
    this.showLoginOverlay = false,
  });

  const AppState.authenticated(
    User user,
  ) : this(
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.onboardingRequired(User user)
      : this(
          status: AppStatus.onboardingRequired,
          user: user,
        );

  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;
  final bool showLoginOverlay;
  bool get isUserSubscribed => user.subscriptionPlan != SubscriptionPlan.none;

  @override
  List<Object?> get props => [
        status,
        user,
        showLoginOverlay,
        isUserSubscribed,
      ];

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

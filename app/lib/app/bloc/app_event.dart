part of "app_bloc.dart";

/// Abstract class representing events that can occur within the application.
///
/// Each concrete event class should extend this class and override the [props]
/// getter to provide the properties that define the uniqueness of the event.
abstract class AppEvent extends Equatable {
  /// Creates an instance of [AppEvent].
  const AppEvent();

  @override
  List<Object> get props => [];
}

/// Event indicating that the user has requested to logout from the application.
class AppLogoutRequested extends AppEvent {
    /// Creates an instance of [AppLogoutRequested].
    const AppLogoutRequested();
}

/// Event indicating that the user has requested to delete their account.
class AppDeleteAccountRequested extends AppEvent {
    /// Creates an instance of [AppDeleteAccountRequested].
    const AppDeleteAccountRequested();
}

/// Event indicating that the current user has changed.
class AppUserChanged extends AppEvent {
  /// Creates an instance of [AppUserChanged] with the given [user].
  const AppUserChanged(this.user);

  /// The updated user information.
  final User user;

  /// Returns a list containing the [user] to determine event equality.
  @override
  List<Object> get props => [user];
}

/// Event indicating that the onboarding process has been completed.
class AppOnboardingCompleted extends AppEvent {
  /// Creates an instance of [AppOnboardingCompleted].
  const AppOnboardingCompleted();
}

/// Event indicating that the application has been opened.
class AppOpened extends AppEvent {
  /// Creates an instance of [AppOpened].
  const AppOpened();
}

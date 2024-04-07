import "package:app/app/app.dart";
import "package:app/home/view/home_page.dart";
import "package:flutter/widgets.dart";

/// Generates a list of application view pages based on the current [state].
///
/// This function takes the current [state] of the application, along with a
/// list of existing [pages], and generates a new list of pages based on the
/// state.
///
/// The [state] parameter represents the current state of the application as
/// defined by the [AppStatus] enum.
///
/// The [pages] parameter is a list of existing pages in the application.
///
/// The function returns a list of [Page] objects representing the view pages
/// that should be displayed based on the provided [state].
List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.onboardingRequired:
      // return [OnboardingPage.page()]; `TODO`: Implement OnboardingPage
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    case AppStatus.authenticated:
      return [HomePage.page()];
  }
}

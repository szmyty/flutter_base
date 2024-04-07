import "dart:async";
import "dart:developer";

import "package:analytics_repository/analytics_repository.dart";
import "package:app/app/bootstrap/app_bloc_observer.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:hydrated_bloc/hydrated_bloc.dart";
import "package:path_provider/path_provider.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Signature for a function that builds the root widget of the application.
///
/// This function is typically used for bootstrapping the initialization
/// of the application. It takes [sharedPreferences] and [analyticsRepository]
/// as parameters and returns a [Future] that completes with the root widget
/// of the application.
///
/// The [sharedPreferences] parameter represents the shared preferences instance
/// used for storing application settings and data.
///
/// The [analyticsRepository] parameter represents the repository responsible
/// for tracking analytics events and user interactions.
///
/// Example usage:
///
/// ```dart
/// Future<Widget> myAppBuilder(
///   SharedPreferences sharedPreferences,
///   AnalyticsRepository analyticsRepository,
/// ) async {
///   // Perform app initialization tasks
///   await MyAppInitializer.init(sharedPreferences, analyticsRepository);
///
///   // Return the root widget of the application
///   return MyApp();
/// }
/// ```
typedef AppBuilder = Future<Widget> Function(
    SharedPreferences sharedPreferences,
    AnalyticsRepository analyticsRepository,
);

Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(
    () async {
        WidgetsFlutterBinding.ensureInitialized();

        final analyticsRepository = FileAnalyticsRepository(FileAnalytics());
        final blocObserver = AppBlocObserver(
            analyticsRepository: analyticsRepository,
        );
        Bloc.observer = blocObserver;
        HydratedBloc.storage = await HydratedStorage.build(
            storageDirectory: await getApplicationSupportDirectory(),
        );

        if (kDebugMode) {
            await HydratedBloc.storage.clear();
        }

          final sharedPreferences = await SharedPreferences.getInstance();

        runApp(
            await builder(
                sharedPreferences,
                analyticsRepository,
            ),
        );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

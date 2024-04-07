import "package:app/app/app.dart";
import "package:app_ui/app_ui.dart";
import "package:flow_builder/flow_builder.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// A widget representing the root of the application's view hierarchy.
///
/// This widget configures the application's overall theme mode and themes, and
/// sets up the root widget tree based on the current authentication status.
///
/// The [AppView] widget is responsible for defining the MaterialApp and setting
/// up the appropriate theme and home widget based on the current authentication
/// status provided by the [AppBloc].
class AppView extends StatelessWidget {
  /// Creates an [AppView] widget.
  ///
  /// The [key] parameter is an optional [Key] to use for the widget.
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: const AppTheme().themeData,
      darkTheme: const AppDarkTheme().themeData,
      home: AuthenticatedUserListener(
        child: FlowBuilder<AppStatus>(
          state: context.select(
            (AppBloc bloc) => bloc.state.status,
          ),
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
  }
}

import "package:app/feed/bloc/feed_bloc.dart";
import "package:app/home/cubit/home_cubit.dart";
import "package:app/home/view/home_view.dart";
import "package:feed_repository/feed_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// A widget representing the home page of the application.
///
/// The [HomePage] widget serves as the main entry point of the application's
/// user interface. It typically contains the primary content and functionality
/// for the user to interact with.
class HomePage extends StatelessWidget {
  /// Creates a [HomePage] widget.
  ///
  /// The [key] parameter is an optional [Key] to use for the widget.
  const HomePage({super.key});

  /// Creates a [Page] object representing the home page.
  ///
  /// This static method is used to generate a [Page] object that can be
  /// included in the application's navigation stack.
  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeedBloc(
            feedRepository: context.read<FeedRepository>(),
          ),
        ),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: const HomeView(),
    );
  }
}

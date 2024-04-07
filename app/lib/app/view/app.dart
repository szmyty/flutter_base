import "package:analytics_repository/analytics_repository.dart";
import "package:app/analytics/analytics.dart";
import "package:app/app/app.dart";
import "package:app/app/view/app_view.dart";
import "package:feed_repository/feed_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:user_repository/user_repository.dart";

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required FeedRepository feedRepository,
    required AnalyticsRepository analyticsRepository,
    required User user,
    super.key,
  })  : _userRepository = userRepository,
        _feedRepository = feedRepository,
        _analyticsRepository = analyticsRepository,
        _user = user;

  final UserRepository _userRepository;
  final FeedRepository _feedRepository;
  final AnalyticsRepository _analyticsRepository;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _feedRepository),
        RepositoryProvider.value(value: _analyticsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              userRepository: _userRepository,
            //   notificationsRepository: _notificationsRepository,
              user: _user,
            )..add(const AppOpened()),
          ),
        //   BlocProvider(create: (_) => ThemeModeBloc()),
        //   BlocProvider(
        //     create: (_) => LoginWithEmailLinkBloc(
        //       userRepository: _userRepository,
        //     ),
        //     lazy: false,
        //   ),
          BlocProvider(
            create: (context) => AnalyticsBloc(
              analyticsRepository: _analyticsRepository,
              userRepository: _userRepository,
            ),
            lazy: false,
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

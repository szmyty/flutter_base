import "package:analytics_repository/analytics_repository.dart";
import "package:app/app/app.dart";
import "package:app/app/bootstrap/bootstrap.dart";
import "package:app_api/client.dart";
import "package:feed_repository/feed_repository.dart";
import "package:flutter/foundation.dart";
import "package:package_info_client/package_info_client.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:permission_client/permission_client.dart";
import "package:persistent_storage/persistent_storage.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:token_storage/token_storage.dart";
import "package:user_repository/user_repository.dart";


void main() {
    BindingBase.debugZoneErrorsAreFatal = true;
    bootstrap((sharedPreferences, analyticsRepository) async {
        return await Bootstrapper.bootstrap(
            sharedPreferences, analyticsRepository,
        );
    });
}

class Bootstrapper {
  static Future<App> bootstrap(
    SharedPreferences sharedPreferences,
    AnalyticsRepository analyticsRepository,
  ) async {
    final tokenStorage = InMemoryTokenStorage();

    final apiClient = ApiClient.localhost(
      tokenProvider: tokenStorage.readToken,
    );

    const permissionClient = PermissionClient();

    final persistentStorage = PersistentStorage(
      sharedPreferences: sharedPreferences,
    );

    final packageInfo = await PackageInfo.fromPlatform();

    final packageInfoClient = PackageInfoClient(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      packageVersion: packageInfo.version,
    );

    final userStorage = UserStorage(storage: persistentStorage);

    final authenticationClient = FirebaseAuthenticationClient(
        tokenStorage: tokenStorage,
    );

    final userRepository = UserRepository(
        apiClient: apiClient,
        authenticationClient: authenticationClient,
        packageInfoClient: packageInfoClient,
        // deepLinkClient: deepLinkClient,
        storage: userStorage,
    );

    final feedRepository = FeedRepository(
      apiClient: apiClient,
    //   userStorage: userStorage,
    );

    // final notificationsRepository = NotificationsRepository(
    //   permissionClient: permissionClient,
    //   storage: NotificationsStorage(storage: persistentStorage),
    //   notificationsClient: notificationsClient,
    //   apiClient: apiClient,
    // );

    return App(
      userRepository: userRepository,
      feedRepository: feedRepository,
    //   notificationsRepository: notificationsRepository,
      analyticsRepository: analyticsRepository,
      user: await userRepository.user.first,
    );
  }
}

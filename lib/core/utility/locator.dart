import 'package:get_it/get_it.dart';
import 'package:pundi_kita/core/utility/shared_preferences_helper.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_service.dart';

final GetIt G = GetIt.instance;

void initLocator([SharedPreferences sharedPreferences]) {
  G.registerSingleton(
    SharedPreferencesService(sharedPreferences),
  );
}

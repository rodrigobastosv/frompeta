import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const FAVORITE_CARS = 'favorite_cars';

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);

  SharedPreferences sharedPreferences;

  Future<Map<String, dynamic>> getFavoriteCarsMap() async {
    final carsEncoded = sharedPreferences.getString(FAVORITE_CARS);
    return carsEncoded != null ? await jsonDecode(carsEncoded) as Map : {};
  }

  Future<void> favoriteCar(String carId) async {
    try {
      final favoriteCarsMap = await getFavoriteCarsMap();
      if (favoriteCarsMap.containsKey(carId)) {
        favoriteCarsMap[carId] = true;
      } else {
        favoriteCarsMap.putIfAbsent(carId, () => true);
      }
      final updatedCarsEncoded = jsonEncode(favoriteCarsMap);
      sharedPreferences.setString(FAVORITE_CARS, updatedCarsEncoded);
    } on Exception {
      rethrow;
    }
  }

  Future<void> unfavoriteCar(String carId) async {
    try {
      final favoriteCarsMap = await getFavoriteCarsMap();
      if (favoriteCarsMap.containsKey(carId)) {
        favoriteCarsMap[carId] = false;
      } else {
        favoriteCarsMap.putIfAbsent(carId, () => false);
      }
      final updatedCarsEncoded = jsonEncode(favoriteCarsMap);
      sharedPreferences.setString(FAVORITE_CARS, updatedCarsEncoded);
    } on Exception {
      rethrow;
    }
  }
}

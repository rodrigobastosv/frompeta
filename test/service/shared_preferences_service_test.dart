import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/service/shared_preferences_service.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({
    FAVORITE_CARS: {},
  });
  MockSharedPreferences mockSharedPreferences;
  SharedPreferencesService sharedPreferencesService;

  group('SharedPreferencesService tests', () {
    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      sharedPreferencesService =
          SharedPreferencesService(mockSharedPreferences);
    });

    test('getFavoriteCarsMap', () async {
      final map = await sharedPreferencesService.getFavoriteCarsMap();
      expect(map, {});
    });

    group('favoriteCar', () {
      test('should favorite a car not in prefs', () async {
        await sharedPreferencesService.favoriteCar('1');
      });

      test('should favorite a car in prefs', () async {
        when(mockSharedPreferences.getString(FAVORITE_CARS)).thenReturn(
          jsonEncode(
            {
              '1': true,
            },
          ),
        );
        await sharedPreferencesService.favoriteCar('1');
      });

      test('should throw exception', () async {
        when(mockSharedPreferences.getString(FAVORITE_CARS))
            .thenThrow(Exception());
        expect(sharedPreferencesService.favoriteCar('1'), throwsException);
      });
    });

    group('unfavoriteCar', () {
      test('should unfavorite a car not in prefs', () async {
        await sharedPreferencesService.unfavoriteCar('1');
      });

      test('should unfavorite a car in prefs', () async {
        when(mockSharedPreferences.getString(FAVORITE_CARS)).thenReturn(
          jsonEncode(
            {
              '1': true,
            },
          ),
        );
        await sharedPreferencesService.unfavoriteCar('1');
      });

      test('should throw exception', () async {
        when(mockSharedPreferences.getString(FAVORITE_CARS))
            .thenThrow(Exception());
        expect(sharedPreferencesService.unfavoriteCar('1'), throwsException);
      });
    });
  });
}

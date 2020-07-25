import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_state.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_state.dart';
import 'package:flutterdryve/repository/abstract/cars_feed_repository.dart';
import 'package:flutterdryve/service/shared_preferences_service.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MockCarsFeedRepository extends Mock implements CarsFeedRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

class MockCarsFeedCubit extends MockBloc<CarsFeedState>
    implements CarsFeedCubit {}

class MockCarsFilterCubit extends MockBloc<CarsFilterState>
    implements CarsFilterCubit {}

class MockPanelController extends Mock implements PanelController {}

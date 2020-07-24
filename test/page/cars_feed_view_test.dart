import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_state.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:flutterdryve/page/cars_feed_view.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('CarsFeedView tests', () {
    testWidgets('should build without exploding', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      final mockCarsFilterCubit = MockCarsFilterCubit();
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CarsFeedCubit>(
                create: (_) => mockCarsFeedCubit,
              ),
              BlocProvider<CarsFilterCubit>(
                create: (_) => mockCarsFilterCubit,
              ),
            ],
            child: CarsFeedView(),
          ),
        ),
      );
    });

    testWidgets('should show cars', (tester) async {
      final cars = [
        CarModel(id: '1'),
        CarModel(id: '2'),
      ];
      final brands = [
        BrandModel(brandId: '1', name: 'Audi'),
      ];
      final colors = [
        ColorModel(colorId: '1', name: 'Azul'),
      ];
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
      when(mockCarsFeedCubit.allBrands).thenReturn(brands);
      when(mockCarsFeedCubit.allColors).thenReturn(colors);
      when(mockCarsFeedCubit.state).thenReturn(
        FetchInfoSuccess(
          cars: cars,
          brands: brands,
          colors: colors,
        ),
      );
      final mockCarsFilterCubit = MockCarsFilterCubit();
      when(mockCarsFilterCubit.pickedBrands).thenReturn([]);
      when(mockCarsFilterCubit.pickedColors).thenReturn([]);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CarsFeedCubit>(
                create: (_) => mockCarsFeedCubit,
              ),
              BlocProvider<CarsFilterCubit>(
                create: (_) => mockCarsFilterCubit,
              ),
            ],
            child: CarsFeedView(),
          ),
        ),
      );
    });

    testWidgets('should close sliding panel', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.state).thenReturn(InitialCarsFeed());
      whenListen(
        mockCarsFeedCubit,
        Stream.fromIterable(
          [
            FetchInfoSuccess(
              cars: [
                CarModel(id: '1'),
              ],
              brands: [
                BrandModel(brandId: '1'),
              ],
              colors: [
                ColorModel(colorId: '1'),
              ],
            ),
            ClosedSlidingPanel(),
          ],
        ),
      );
      final mockCarsFilterCubit = MockCarsFilterCubit();
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CarsFeedCubit>(
                create: (_) => mockCarsFeedCubit,
              ),
              BlocProvider<CarsFilterCubit>(
                create: (_) => mockCarsFilterCubit,
              ),
            ],
            child: CarsFeedView(),
          ),
        ),
      );
    });
  });
}

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
import 'package:flutterdryve/page/widget/cars_filter.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() {
  final cars = [
    CarModel(
      id: '1',
      transmissionType: 'type',
      modelYear: 2020,
      modelName: 'Audi',
      mileage: 1000,
      price: 2000,
      imageUrl: 'image',
      fuelType: 'fuel',
      brandName: 'QQ',
    ),
    CarModel(
      id: '2',
      transmissionType: 'type',
      modelYear: 2020,
      modelName: 'Audi',
      mileage: 1000,
      price: 2000,
      imageUrl: 'image',
      fuelType: 'fuel',
      brandName: 'QQ',
    ),
  ];
  final brands = [
    BrandModel(brandId: '1', name: 'Audi'),
  ];
  final colors = [
    ColorModel(colorId: '1', name: 'Azul'),
  ];

  group('CarsFilter tests', () {
    testWidgets('should build without exploding', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
      when(mockCarsFeedCubit.allBrands).thenReturn(brands);
      when(mockCarsFeedCubit.allColors).thenReturn(colors);
      final mockCarsFilterCubit = MockCarsFilterCubit();
      when(mockCarsFilterCubit.isColorPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.isBrandPicked(any)).thenReturn(false);
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
            child: Scaffold(
              body: CarsFilter(),
            ),
          ),
        ),
      );
    });

    testWidgets('should clear the filters', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
      when(mockCarsFeedCubit.allBrands).thenReturn(brands);
      when(mockCarsFeedCubit.allColors).thenReturn(colors);
      final mockCarsFilterCubit = MockCarsFilterCubit();
      when(mockCarsFilterCubit.isColorPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.isBrandPicked(any)).thenReturn(false);
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
            child: Scaffold(
              body: CarsFilter(),
            ),
          ),
        ),
      );
      final limparBtn = find.byKey(const ValueKey('limpar-btn'));
      expect(limparBtn, findsOneWidget);
      await tester.tap(limparBtn);
      verify(mockCarsFilterCubit.clearFilters()).called(1);
    });

    testWidgets('should apply the filters and close the sliding',
        (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
      when(mockCarsFeedCubit.allBrands).thenReturn(brands);
      when(mockCarsFeedCubit.allColors).thenReturn(colors);
      final mockCarsFilterCubit = MockCarsFilterCubit();
      when(mockCarsFilterCubit.isColorPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.isBrandPicked(any)).thenReturn(false);
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
            child: Scaffold(
              body: CarsFilter(),
            ),
          ),
        ),
      );
      final aplicarBtn = find.byKey(const ValueKey('aplicar-btn'));
      expect(aplicarBtn, findsOneWidget);
      await tester.tap(aplicarBtn);
      verify(
        mockCarsFeedCubit.applyFiltersOnSearch(
          brands: [],
          colors: [],
        ),
      ).called(1);
      verify(mockCarsFeedCubit.closeSlidingPanel());
    });

    testWidgets('should build when state is OpenedSlidingPanel',
        (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.state).thenReturn(InitialCarsFeed());
      whenListen(
        mockCarsFeedCubit,
        Stream.fromIterable(
          [
            OpenedSlidingPanel(),
            ClosedSlidingPanel(),
            OpenedSlidingPanel(),
          ],
        ),
      );
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
      when(mockCarsFeedCubit.allBrands).thenReturn(brands);
      when(mockCarsFeedCubit.allColors).thenReturn(colors);
      final mockCarsFilterCubit = MockCarsFilterCubit();
      when(mockCarsFilterCubit.isColorPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.isBrandPicked(any)).thenReturn(false);
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
            child: Scaffold(
              body: CarsFilter(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });
  });
}

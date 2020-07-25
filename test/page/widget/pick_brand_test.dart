import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:flutterdryve/page/widget/pick_brand.dart';
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
    BrandModel(brandId: '2', name: 'Ford'),
    BrandModel(brandId: '3', name: 'Ferrari'),
  ];
  final colors = [
    ColorModel(colorId: '1', name: 'Azul'),
  ];

  group('PickBrand tests', () {
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
              body: PickBrand(brands),
            ),
          ),
        ),
      );
    });

    testWidgets('should pick a brand', (tester) async {
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
              body: PickBrand(brands),
            ),
          ),
        ),
      );
      final checkbox = find.byType(Checkbox).first;
      expect(checkbox, findsOneWidget);
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      verify(mockCarsFilterCubit.pickBrand(any)).called(1);
    });

    testWidgets('should unpick a brand', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
      when(mockCarsFeedCubit.allBrands).thenReturn(brands);
      when(mockCarsFeedCubit.allColors).thenReturn(colors);
      final mockCarsFilterCubit = MockCarsFilterCubit();
      when(mockCarsFilterCubit.isColorPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.isBrandPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.pickedBrands).thenReturn([]);
      when(mockCarsFilterCubit.isBrandPicked(any)).thenReturn(true);
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
              body: PickBrand(brands),
            ),
          ),
        ),
      );
      final checkbox = find.byType(Checkbox).first;
      expect(checkbox, findsOneWidget);
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      verify(mockCarsFilterCubit.unpickBrand(any)).called(1);
    });
  });
}

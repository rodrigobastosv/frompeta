import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:flutterdryve/page/widget/pick_color.dart';
import 'package:mockito/mockito.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

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
  final colors = [
    ColorModel(colorId: '1', name: 'Azul'),
    ColorModel(colorId: '2', name: 'Amarelo'),
    ColorModel(colorId: '3', name: 'Verde'),
    ColorModel(colorId: '4', name: 'Vermelho'),
  ];

  group('PickColor tests', () {
    testWidgets('should build without exploding', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
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
              body: PickColor(colors),
            ),
          ),
        ),
      );
    });

    testWidgets('should pick a color', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
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
              body: PickColor(colors),
            ),
          ),
        ),
      );
      final checkbox = find.byType(RoundCheckBox).first;
      expect(checkbox, findsOneWidget);
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      verify(mockCarsFilterCubit.pickColor(any)).called(1);
    });

    testWidgets('should unpick a color', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      when(mockCarsFeedCubit.allCars).thenReturn(cars);
      when(mockCarsFeedCubit.allColors).thenReturn(colors);
      final mockCarsFilterCubit = MockCarsFilterCubit();
      when(mockCarsFilterCubit.isColorPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.isBrandPicked(any)).thenReturn(false);
      when(mockCarsFilterCubit.pickedBrands).thenReturn([]);
      when(mockCarsFilterCubit.isColorPicked(any)).thenReturn(true);
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
              body: PickColor(colors),
            ),
          ),
        ),
      );
      final checkbox = find.byType(RoundCheckBox).first;
      expect(checkbox, findsOneWidget);
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      verify(mockCarsFilterCubit.unpickColor(any)).called(1);
    });
  });
}

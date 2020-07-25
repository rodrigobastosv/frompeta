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
import 'package:image_test_utils/image_test_utils.dart';
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
            child: CarsFeedView(
              panelController: MockPanelController(),
            ),
          ),
        ),
      );
    });

    testWidgets('should close the panel when ClosedSlidingPanel',
        (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      final mockPanelController = MockPanelController();
      when(mockPanelController.isAttached).thenReturn(true);
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
            child: CarsFeedView(panelController: mockPanelController),
          ),
        ),
      );
    });

    testWidgets('should show cars', (tester) async {
      provideMockedNetworkImages(() async {
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
        final mockCarsFeedCubit = MockCarsFeedCubit();
        when(mockCarsFeedCubit.isCarFavorite(any)).thenReturn(true);
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
              child: CarsFeedView(
                panelController: MockPanelController(),
              ),
            ),
          ),
        );
      });
    });

    testWidgets('should filter cars', (tester) async {
      provideMockedNetworkImages(() async {
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
        final mockCarsFeedCubit = MockCarsFeedCubit();
        when(mockCarsFeedCubit.isCarFavorite(any)).thenReturn(false);
        when(mockCarsFeedCubit.allCars).thenReturn(cars);
        when(mockCarsFeedCubit.allBrands).thenReturn(brands);
        when(mockCarsFeedCubit.allColors).thenReturn(colors);
        when(mockCarsFeedCubit.state).thenReturn(
          CarsFiltered(
            cars: cars,
            brands: brands,
            colors: colors,
          ),
        );
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
              child: CarsFeedView(
                panelController: MockPanelController(),
              ),
            ),
          ),
        );
      });
    });
  });
}

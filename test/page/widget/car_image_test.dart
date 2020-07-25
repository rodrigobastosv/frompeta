import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:flutterdryve/page/car_info_page.dart';
import 'package:flutterdryve/page/widget/car_image.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() {
  group('CarImage tests', () {
    testWidgets('should navigate to CarInfoPage when clicking image',
        (tester) async {
      provideMockedNetworkImages(() async {
        final mockCarsFeedCubit = MockCarsFeedCubit();
        when(mockCarsFeedCubit.isCarFavorite(any)).thenReturn(false);
        when(mockCarsFeedCubit.allColors).thenReturn(
          [
            ColorModel(colorId: '1', name: 'Azul'),
            ColorModel(colorId: '2', name: 'Amarelo'),
            ColorModel(colorId: '3', name: 'Verde'),
            ColorModel(colorId: '4', name: 'Preto'),
          ],
        );
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: [
                BlocProvider<CarsFeedCubit>(
                  create: (_) => mockCarsFeedCubit,
                ),
              ],
              child: Scaffold(
                body: CarImage(
                  CarModel(
                    id: '1',
                    colorId: 1,
                    transmissionType: 'type',
                    modelYear: 2020,
                    modelName: 'Audi',
                    mileage: 1000,
                    price: 2000,
                    imageUrl: 'image',
                    fuelType: 'fuel',
                    brandName: 'QQ',
                  ),
                ),
              ),
            ),
          ),
        );
        final image = find.byKey(const ValueKey('car-image'));
        expect(image, findsOneWidget);
        await tester.tap(image);
        await tester.pumpAndSettle();
        expect(find.byType(CarInfoPage), findsOneWidget);
      });
    });

    testWidgets('should favorite car', (tester) async {
      provideMockedNetworkImages(() async {
        final mockCarsFeedCubit = MockCarsFeedCubit();
        when(mockCarsFeedCubit.isCarFavorite(any)).thenReturn(false);
        when(mockCarsFeedCubit.allColors).thenReturn(
          [
            ColorModel(colorId: '1', name: 'Azul'),
            ColorModel(colorId: '2', name: 'Amarelo'),
            ColorModel(colorId: '3', name: 'Verde'),
            ColorModel(colorId: '4', name: 'Preto'),
          ],
        );
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: [
                BlocProvider<CarsFeedCubit>(
                  create: (_) => mockCarsFeedCubit,
                ),
              ],
              child: Scaffold(
                body: CarImage(
                  CarModel(
                    id: '1',
                    colorId: 1,
                    transmissionType: 'type',
                    modelYear: 2020,
                    modelName: 'Audi',
                    mileage: 1000,
                    price: 2000,
                    imageUrl: 'image',
                    fuelType: 'fuel',
                    brandName: 'QQ',
                  ),
                ),
              ),
            ),
          ),
        );
        final favoriteIcon = find.byKey(const ValueKey('favorite-icon'));
        expect(favoriteIcon, findsOneWidget);
        await tester.tap(favoriteIcon);
        await tester.pumpAndSettle();
        verify(mockCarsFeedCubit.favoriteCar('1')).called(1);
      });
    });

    testWidgets('should unfavorite car', (tester) async {
      provideMockedNetworkImages(() async {
        final mockCarsFeedCubit = MockCarsFeedCubit();
        when(mockCarsFeedCubit.isCarFavorite(any)).thenReturn(true);
        when(mockCarsFeedCubit.allColors).thenReturn(
          [
            ColorModel(colorId: '1', name: 'Azul'),
            ColorModel(colorId: '2', name: 'Amarelo'),
            ColorModel(colorId: '3', name: 'Verde'),
            ColorModel(colorId: '4', name: 'Preto'),
          ],
        );
        await tester.pumpWidget(
          MaterialApp(
            home: MultiBlocProvider(
              providers: [
                BlocProvider<CarsFeedCubit>(
                  create: (_) => mockCarsFeedCubit,
                ),
              ],
              child: Scaffold(
                body: CarImage(
                  CarModel(
                    id: '1',
                    colorId: 1,
                    transmissionType: 'type',
                    modelYear: 2020,
                    modelName: 'Audi',
                    mileage: 1000,
                    price: 2000,
                    imageUrl: 'image',
                    fuelType: 'fuel',
                    brandName: 'QQ',
                  ),
                ),
              ),
            ),
          ),
        );
        final favoriteIcon = find.byKey(const ValueKey('favorite-icon'));
        expect(favoriteIcon, findsOneWidget);
        await tester.tap(favoriteIcon);
        await tester.pumpAndSettle();
        verify(mockCarsFeedCubit.unfavoriteCar('1')).called(1);
      });
    });
  });
}

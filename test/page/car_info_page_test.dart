import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:flutterdryve/page/car_info_page.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('CarInfoPage tests', () {
    testWidgets('should build without exploding', (tester) async {
      provideMockedNetworkImages(() async {
        final mockCarsFeedCubit = MockCarsFeedCubit();
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
              child: CarInfoPage(
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
        );
      });
    });
  });
}

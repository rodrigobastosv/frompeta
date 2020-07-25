import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_state.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() {
  group('CarsFeedCubit tests', () {
    CarsFeedCubit carsFeedCubit;
    MockCarsFeedRepository mockCarsFeedRepository;
    MockSharedPreferencesService mockSharedPreferencesService;

    final carList = [
      CarModel(
        id: '1',
        brandId: 1,
        colorId: 1,
      ),
      CarModel(
        id: '2',
        brandId: 2,
        colorId: 1,
      ),
      CarModel(
        id: '2',
        brandId: 3,
        colorId: 2,
      ),
    ];

    final brandList = [
      BrandModel(brandId: '1', name: 'Audi'),
      BrandModel(brandId: '2', name: 'QQ'),
    ];

    final colorList = [
      ColorModel(colorId: '1', name: 'Vermelho'),
      ColorModel(colorId: '2', name: 'Azul'),
    ];

    setUp(() {
      mockCarsFeedRepository = MockCarsFeedRepository();
      mockSharedPreferencesService = MockSharedPreferencesService();
      carsFeedCubit = CarsFeedCubit(
        repository: mockCarsFeedRepository,
        sharedPreferencesService: mockSharedPreferencesService,
      );
    });

    tearDown(() {
      carsFeedCubit?.close();
    });

    test('asserts', () {
      expect(
          () => CarsFeedCubit(
                repository: null,
                sharedPreferencesService: MockSharedPreferencesService(),
              ),
          throwsAssertionError);

      expect(
          () => CarsFeedCubit(
                repository: MockCarsFeedRepository(),
                sharedPreferencesService: null,
              ),
          throwsAssertionError);
    });

    test('''Expects InitialCarsFeed to be the initial state''', () {
      expect(carsFeedCubit.state, equals(InitialCarsFeed()));
    });

    test('isCarFavorite', () {
      carsFeedCubit.favoriteCarsMap = {
        '1': true,
      };
      expect(
        carsFeedCubit.isCarFavorite(
          CarModel(
            id: '1',
            brandId: 1,
            colorId: 1,
          ),
        ),
        true,
      );
      expect(
        carsFeedCubit.isCarFavorite(
          CarModel(
            id: '2',
            brandId: 1,
            colorId: 1,
          ),
        ),
        false,
      );
    });

    blocTest(
      'Expects [LoadingInfo, FetchInfoSuccess] when fetchAllInfo()',
      build: () {
        when(mockCarsFeedRepository.fetchAllCars()).thenAnswer(
          (_) => Future.value(carList),
        );
        when(mockCarsFeedRepository.fetchAllBrands()).thenAnswer(
          (_) => Future.value(
            brandList,
          ),
        );
        when(mockCarsFeedRepository.fetchAllColors()).thenAnswer(
          (_) => Future.value(
            colorList,
          ),
        );
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.fetchAllInfo();
      },
      expect: [
        LoadingInfo(),
        FetchInfoSuccess(
          cars: carList,
          brands: brandList,
          colors: colorList,
        ),
      ],
    );

    blocTest(
      'Expects [LoadingInfo, FetchInfoFailed] when fetchAllInfo() fails',
      build: () {
        when(mockCarsFeedRepository.fetchAllCars()).thenThrow(Exception());
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.fetchAllInfo();
      },
      expect: [
        LoadingInfo(),
        FetchInfoFailed(),
      ],
    );

    blocTest(
      'Should return all cars when filters are empty',
      build: () {
        carsFeedCubit.allCars = carList;
        carsFeedCubit.allBrands = brandList;
        carsFeedCubit.allColors = colorList;
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.applyFiltersOnSearch(
          brands: <BrandModel>[],
          colors: <ColorModel>[],
        );
      },
      expect: [
        CarsFiltered(
          cars: carList,
          brands: [],
          colors: [],
        ),
      ],
    );

    blocTest(
      'Should filter cars when brand picked',
      build: () {
        carsFeedCubit.allCars = carList;
        carsFeedCubit.allBrands = brandList;
        carsFeedCubit.allColors = colorList;
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.applyFiltersOnSearch(
          brands: [
            BrandModel(brandId: '1', name: 'Audi'),
          ],
          colors: <ColorModel>[],
        );
      },
      expect: [
        CarsFiltered(
          cars: [
            CarModel(
              id: '1',
              brandId: 1,
            ),
          ],
          brands: [
            BrandModel(brandId: '1', name: 'Audi'),
          ],
          colors: [],
        ),
      ],
    );

    blocTest(
      'Should filter cars when color picked',
      build: () {
        carsFeedCubit.allCars = carList;
        carsFeedCubit.allBrands = brandList;
        carsFeedCubit.allColors = colorList;
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.applyFiltersOnSearch(
          brands: <BrandModel>[],
          colors: <ColorModel>[
            ColorModel(colorId: '1', name: 'Vermelho'),
          ],
        );
      },
      expect: [
        CarsFiltered(
          cars: [
            CarModel(
              id: '1',
              brandId: 1,
              colorId: 1,
            ),
            CarModel(
              id: '2',
              brandId: 2,
              colorId: 1,
            ),
          ],
          brands: [],
          colors: [
            ColorModel(colorId: '1', name: 'Vermelho'),
          ],
        ),
      ],
    );

    blocTest(
      'Should filter cars when brand and color are picked',
      build: () {
        carsFeedCubit.allCars = carList;
        carsFeedCubit.allBrands = brandList;
        carsFeedCubit.allColors = colorList;
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.applyFiltersOnSearch(
          brands: <BrandModel>[
            BrandModel(brandId: '1', name: 'Audi'),
          ],
          colors: <ColorModel>[
            ColorModel(colorId: '1', name: 'Vermelho'),
          ],
        );
      },
      expect: [
        CarsFiltered(
          cars: [
            CarModel(
              id: '1',
              brandId: 1,
              colorId: 1,
            ),
          ],
          brands: [
            BrandModel(brandId: '1', name: 'Audi'),
          ],
          colors: [
            ColorModel(colorId: '1', name: 'Vermelho'),
          ],
        ),
      ],
    );

    blocTest(
      'Should favorite a car',
      build: () {
        carsFeedCubit.allCars = carList;
        carsFeedCubit.allBrands = brandList;
        carsFeedCubit.allColors = colorList;
        when(mockSharedPreferencesService.getFavoriteCarsMap())
            .thenAnswer((_) => Future.value({}));
        when(mockSharedPreferencesService.favoriteCar(any))
            .thenAnswer((_) => Future.value());
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.favoriteCar('1');
      },
      expect: [
        CarFavorited('1'),
      ],
    );

    blocTest(
      'Should unfavorite a car',
      build: () {
        carsFeedCubit.allCars = carList;
        carsFeedCubit.allBrands = brandList;
        carsFeedCubit.allColors = colorList;
        when(mockSharedPreferencesService.getFavoriteCarsMap())
            .thenAnswer((_) => Future.value({}));
        when(mockSharedPreferencesService.unfavoriteCar(any))
            .thenAnswer((_) => Future.value());
        return carsFeedCubit;
      },
      act: (carsFeedCubit) async {
        await carsFeedCubit.unfavoriteCar('1');
      },
      expect: [
        CarUnfavorited('1'),
      ],
    );

    blocTest(
      'Expects [OpenedSlidingPanel] when openSlidingPanel()',
      build: () => carsFeedCubit,
      act: (carsFeedCubit) async {
        await carsFeedCubit.openSlidingPanel();
      },
      expect: [
        OpenedSlidingPanel(),
      ],
    );

    blocTest(
      'Expects [ClosedSlidingPanel] when closeSlidingPanel()',
      build: () => carsFeedCubit,
      act: (carsFeedCubit) async {
        await carsFeedCubit.closeSlidingPanel();
      },
      expect: [
        ClosedSlidingPanel(),
      ],
    );
  });
}

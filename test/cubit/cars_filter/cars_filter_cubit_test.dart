import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_state.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/color_model.dart';

void main() {
  group('CarsFilterCubit tests', () {
    CarsFilterCubit carsFilterCubit;

    setUp(() {
      carsFilterCubit = CarsFilterCubit();
    });

    tearDown(() {
      carsFilterCubit?.close();
    });

    test('''Expects InitialCarsFilter to be the initial state''', () {
      expect(carsFilterCubit.state, equals(InitialCarsFilter()));
    });

    test('countFilters', () {
      expect(carsFilterCubit.countFilters, 0);
    });

    test('isBrandPicked', () {
      carsFilterCubit.pickedBrands = [
        BrandModel(
          brandId: '1',
        ),
      ];
      expect(
        carsFilterCubit.isBrandPicked(
          BrandModel(
            brandId: '1',
          ),
        ),
        true,
      );
      expect(
        carsFilterCubit.isBrandPicked(
          BrandModel(
            brandId: '2',
          ),
        ),
        false,
      );
    });

    test('isColorPicked', () {
      carsFilterCubit.pickedColors = [
        ColorModel(
          colorId: '1',
        ),
      ];
      expect(
        carsFilterCubit.isColorPicked(
          ColorModel(
            colorId: '1',
          ),
        ),
        true,
      );
      expect(
        carsFilterCubit.isColorPicked(
          ColorModel(
            colorId: '2',
          ),
        ),
        false,
      );
    });

    blocTest(
      'pickBrand should emit BrandSelectionChanged',
      build: () {
        return carsFilterCubit;
      },
      act: (carsFilterCubit) async {
        carsFilterCubit.pickBrand(
          BrandModel(
            brandId: '1',
          ),
        );
      },
      expect: [
        BrandSelectionChanged(
          brand: BrandModel(
            brandId: '1',
          ),
          value: true,
        ),
      ],
      verify: (carsFilterCubit) {
        expect(carsFilterCubit.pickedBrands.length, 1);
      },
    );

    blocTest(
      'unpickBrand should emit BrandSelectionChanged',
      build: () {
        carsFilterCubit.pickedBrands = [
          BrandModel(
            brandId: '1',
          ),
        ];
        return carsFilterCubit;
      },
      act: (carsFilterCubit) async {
        carsFilterCubit.unpickBrand(
          BrandModel(
            brandId: '1',
          ),
        );
      },
      expect: [
        BrandSelectionChanged(
          brand: BrandModel(
            brandId: '1',
          ),
          value: false,
        ),
      ],
      verify: (carsFilterCubit) {
        expect(carsFilterCubit.pickedBrands.length, 0);
      },
    );

    blocTest(
      'pickColor should emit ColorSelectionChanged',
      build: () {
        return carsFilterCubit;
      },
      act: (carsFilterCubit) async {
        carsFilterCubit.pickColor(
          ColorModel(
            colorId: '1',
          ),
        );
      },
      expect: [
        ColorSelectionChanged(
          color: ColorModel(
            colorId: '1',
          ),
          value: true,
        ),
      ],
      verify: (carsFilterCubit) {
        expect(carsFilterCubit.pickedColors.length, 1);
      },
    );

    blocTest(
      'unpickColor should emit ColorSelectionChanged',
      build: () {
        carsFilterCubit.pickedColors = [
          ColorModel(
            colorId: '1',
          ),
        ];
        return carsFilterCubit;
      },
      act: (carsFilterCubit) async {
        carsFilterCubit.unpickColor(
          ColorModel(
            colorId: '1',
          ),
        );
      },
      expect: [
        ColorSelectionChanged(
          color: ColorModel(
            colorId: '1',
          ),
          value: false,
        ),
      ],
      verify: (carsFilterCubit) {
        expect(carsFilterCubit.pickedColors.length, 0);
      },
    );

    blocTest(
      'clearFilters should reset to initial state',
      build: () {
        return carsFilterCubit;
      },
      act: (carsFilterCubit) async {
        carsFilterCubit.clearFilters();
      },
      expect: [
        InitialCarsFilter(),
      ],
    );
  });
}

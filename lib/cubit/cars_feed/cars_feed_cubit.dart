import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:flutterdryve/repository/abstract/cars_feed_repository.dart';
import 'package:flutterdryve/service/shared_preferences_service.dart';

import 'cars_feed_state.dart';

class CarsFeedCubit extends Cubit<CarsFeedState> {
  CarsFeedCubit(
      {@required this.repository, @required this.sharedPreferencesService})
      : assert(repository != null),
        assert(sharedPreferencesService != null),
        super(InitialCarsFeed());

  final CarsFeedRepository repository;
  final SharedPreferencesService sharedPreferencesService;

  List<CarModel> allCars = [];
  List<BrandModel> allBrands = [];
  List<ColorModel> allColors = [];

  Map<String, dynamic> favoriteCarsMap;

  Future<void> fetchAllInfo() async {
    emit(LoadingInfo());

    try {
      favoriteCarsMap = await sharedPreferencesService.getFavoriteCarsMap();
      allCars = await repository.fetchAllCars();
      allBrands = await repository.fetchAllBrands();
      allColors = await repository.fetchAllColors();

      emit(
        FetchInfoSuccess(
          cars: allCars,
          brands: allBrands,
          colors: allColors,
        ),
      );
    } on Exception {
      emit(FetchInfoFailed());
    }
  }

  void applyFiltersOnSearch(
      {List<BrandModel> brands, List<ColorModel> colors}) {
    if (brands.isEmpty && colors.isEmpty) {
      emit(
        CarsFiltered(
          cars: allCars,
          brands: brands,
          colors: colors,
        ),
      );
    } else if (brands.isNotEmpty) {
      final brandsIds = brands.map((brand) => brand.brandId).toList();
      final carsFilteredByBrands = allCars
          .where((car) => brandsIds.contains(car.brandId.toString()))
          .toList();

      if (colors.isEmpty) {
        emit(
          CarsFiltered(
            cars: carsFilteredByBrands,
            brands: brands,
            colors: colors,
          ),
        );
      } else {
        final colorsIds = colors.map((color) => color.colorId).toList();
        final carsFilteredByBrandsAndColors = carsFilteredByBrands
            .where((car) => colorsIds.contains(car.colorId.toString()))
            .toList();

        emit(
          CarsFiltered(
            cars: carsFilteredByBrandsAndColors,
            brands: brands,
            colors: colors,
          ),
        );
      }
    } else if (colors.isNotEmpty) {
      final colorsIds = colors.map((color) => color.colorId).toList();
      final carsFilteredByColors = allCars
          .where((car) => colorsIds.contains(car.colorId.toString()))
          .toList();

      emit(
        CarsFiltered(
          cars: carsFilteredByColors,
          brands: brands,
          colors: colors,
        ),
      );
    }
  }

  Future<void> favoriteCar(String carId) async {
    await sharedPreferencesService.favoriteCar(carId);
    favoriteCarsMap = {
      ...await sharedPreferencesService.getFavoriteCarsMap(),
    };
    emit(CarFavorited(carId));
  }

  Future<void> unfavoriteCar(String carId) async {
    await sharedPreferencesService.unfavoriteCar(carId);
    favoriteCarsMap = {
      ...await sharedPreferencesService.getFavoriteCarsMap(),
    };
    emit(CarUnfavorited(carId));
  }

  bool isCarFavorite(CarModel car) {
    if (favoriteCarsMap.containsKey(car.id)) {
      return favoriteCarsMap[car.id];
    }
    return false;
  }

  void openSlidingPanel() {
    emit(OpenedSlidingPanel());
  }

  void closeSlidingPanel() {
    emit(ClosedSlidingPanel());
  }
}

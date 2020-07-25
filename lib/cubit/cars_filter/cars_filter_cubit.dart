import 'package:bloc/bloc.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/color_model.dart';

import 'cars_filter_state.dart';

class CarsFilterCubit extends Cubit<CarsFilterState> {
  CarsFilterCubit() : super(InitialCarsFilter());

  List<BrandModel> pickedBrands = [];
  List<ColorModel> pickedColors = [];

  int get countFilters => pickedBrands.length + pickedColors.length;

  void pickBrand(BrandModel brand) {
    pickedBrands = [
      ...pickedBrands..add(brand),
    ];
    emit(
      BrandSelectionChanged(
        brand: brand,
        value: true,
      ),
    );
  }

  void unpickBrand(BrandModel brand) {
    pickedBrands = [
      ...pickedBrands..remove(brand),
    ];
    emit(
      BrandSelectionChanged(
        brand: brand,
        value: false,
      ),
    );
  }

  void pickColor(ColorModel color) {
    pickedColors = [
      ...pickedColors..add(color),
    ];
    emit(
      ColorSelectionChanged(
        color: color,
        value: true,
      ),
    );
  }

  void unpickColor(ColorModel color) {
    pickedColors = [
      ...pickedColors..remove(color),
    ];
    emit(
      ColorSelectionChanged(
        color: color,
        value: false,
      ),
    );
  }

  void clearFilters() {
    pickedBrands = [];
    pickedColors = [];
    emit(InitialCarsFilter());
  }

  void filterBrands(List<BrandModel> allBrands, String term) {
    if (term.isEmpty) {
      emit(BrandsFiltered(brands: allBrands));
    }
    final filteredBrands = allBrands
        .where((brand) => brand.name.toUpperCase().contains(term.toUpperCase()))
        .toList();
    emit(BrandsFiltered(brands: filteredBrands));
  }

  bool isBrandPicked(BrandModel brand) {
    return pickedBrands.contains(brand);
  }

  bool isColorPicked(ColorModel color) {
    return pickedColors.contains(color);
  }
}

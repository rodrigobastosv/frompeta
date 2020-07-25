import 'package:equatable/equatable.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/color_model.dart';

abstract class CarsFilterState extends Equatable {
  const CarsFilterState();
}

class InitialCarsFilter extends CarsFilterState {
  @override
  List<Object> get props => [];
}

class BrandSelectionChanged extends CarsFilterState {
  BrandSelectionChanged({this.brand, this.value});

  final BrandModel brand;
  final bool value;

  @override
  List<Object> get props => [brand, value];
}

class ColorSelectionChanged extends CarsFilterState {
  ColorSelectionChanged({this.color, this.value});

  final ColorModel color;
  final bool value;

  @override
  List<Object> get props => [color, value];
}

class BrandsFiltered extends CarsFilterState {
  BrandsFiltered({this.brands});

  final List<BrandModel> brands;

  @override
  List<Object> get props => [brands];
}

import 'package:equatable/equatable.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';

abstract class CarsFeedState extends Equatable {
  const CarsFeedState();
}

class InitialCarsFeed extends CarsFeedState {
  @override
  List<Object> get props => [];
}

class FetchInfoSuccess extends CarsFeedState {
  FetchInfoSuccess({this.cars, this.brands, this.colors});

  final List<CarModel> cars;
  final List<BrandModel> brands;
  final List<ColorModel> colors;

  @override
  List<Object> get props => [cars, brands, colors];
}

class LoadingInfo extends CarsFeedState {
  @override
  List<Object> get props => [];
}

class FetchInfoFailed extends CarsFeedState {
  @override
  List<Object> get props => [];
}

class OpenedSlidingPanel extends CarsFeedState {
  @override
  List<Object> get props => [];
}

class ClosedSlidingPanel extends CarsFeedState {
  @override
  List<Object> get props => [];
}

class CarsFiltered extends CarsFeedState {
  CarsFiltered({this.cars, this.brands, this.colors});

  final List<CarModel> cars;
  final List<BrandModel> brands;
  final List<ColorModel> colors;

  @override
  List<Object> get props => [cars, brands, colors];
}

class CarFavorited extends CarsFeedState {
  CarFavorited(this.carId);

  final String carId;

  @override
  List<Object> get props => [carId];
}

class CarUnfavorited extends CarsFeedState {
  CarUnfavorited(this.carId);

  final String carId;

  @override
  List<Object> get props => [carId];
}

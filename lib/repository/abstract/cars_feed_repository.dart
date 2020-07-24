import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';

abstract class CarsFeedRepository {
  Future<List<CarModel>> fetchAllCars();
  Future<List<BrandModel>> fetchAllBrands();
  Future<List<ColorModel>> fetchAllColors();
}

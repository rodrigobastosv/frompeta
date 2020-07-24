import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:flutterdryve/repository/abstract/cars_feed_repository.dart';

import '../endpoints.dart';

class HttpCarsFeedRepository implements CarsFeedRepository {
  HttpCarsFeedRepository({@required this.client}) : assert(client != null);

  final Dio client;

  @override
  Future<List<CarModel>> fetchAllCars() async {
    final response = await client.get(FETCH_CARS);
    if (response.statusCode == 200) {
      final carsList = response.data as List;
      return List.generate(
          carsList.length, (i) => CarModel.fromJson(carsList[i]));
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<BrandModel>> fetchAllBrands() async {
    final response = await client.get(FETCH_BRANDS);
    if (response.statusCode == 200) {
      final brandsList = response.data as List;
      return List.generate(
          brandsList.length, (i) => BrandModel.fromJson(brandsList[i]));
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ColorModel>> fetchAllColors() async {
    final response = await client.get(FETCH_COLORS);
    if (response.statusCode == 200) {
      final colorsList = response.data as List;
      return List.generate(
          colorsList.length, (i) => ColorModel.fromJson(colorsList[i]));
    } else {
      throw Exception();
    }
  }
}

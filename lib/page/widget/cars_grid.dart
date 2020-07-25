import 'package:flutter/material.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/page/widget/car_tile.dart';

class CarsGrid extends StatelessWidget {
  CarsGrid({@required this.cars}) : assert(cars != null);

  final List<CarModel> cars;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (_, i) => CarTile(cars[i]),
        itemCount: cars.length,
      ),
    );
  }
}

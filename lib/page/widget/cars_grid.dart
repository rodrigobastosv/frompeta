import 'package:flutter/material.dart';
import 'package:flutterdryve/model/car_model.dart';

import 'car_image.dart';
import 'car_info.dart';

class CarsGrid extends StatelessWidget {
  CarsGrid({@required this.cars}) : assert(cars != null);

  final List<CarModel> cars;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (_, i) {
          final car = cars[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: CarImage(car),
              ),
              Expanded(
                child: CarInfo(car),
              )
            ],
          );
        },
        itemCount: cars.length,
      ),
    );
  }
}

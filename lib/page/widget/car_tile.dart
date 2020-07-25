import 'package:flutter/material.dart';
import 'package:flutterdryve/model/car_model.dart';

import 'car_image.dart';
import 'car_info.dart';

class CarTile extends StatelessWidget {
  CarTile(this.car);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey('car-tile${car.id.toString()}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarImage(car),
        CarInfo(car),
      ],
    );
  }
}

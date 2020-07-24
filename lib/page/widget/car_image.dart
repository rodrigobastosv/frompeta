import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterdryve/model/car_model.dart';

class CarImage extends StatelessWidget {
  CarImage(this.car);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(car.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 26,
          ),
        ),
      ],
    );
  }
}

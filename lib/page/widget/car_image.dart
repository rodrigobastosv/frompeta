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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(car.imageUrl),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
        Positioned(
          right: 5,
          child: Icon(
            FontAwesome.heart,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

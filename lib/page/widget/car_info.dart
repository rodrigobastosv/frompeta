import 'package:flutter/material.dart';
import 'package:flutterdryve/model/car_model.dart';

class CarInfo extends StatelessWidget {
  CarInfo(this.car);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          maxLines: 1,
          text: TextSpan(
            children: [
              TextSpan(
                text: ' ${car.modelName.toUpperCase()}',
                style: TextStyle(color: Color(0xFF4b5670), fontSize: 18),
              ),
              TextSpan(
                text: ' ${car.brandName.toUpperCase()}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ),
            ],
          ),
        ),
        Text(
          '${car.modelYear} - ${car.fuelType}',
          style: TextStyle(
            color: Color(0xFF768095),
          ),
        ),
        Text(
          '${car.transmissionType} - ${car.mileage} km',
          style: TextStyle(
            color: Color(0xFF768095),
          ),
        ),
        Text(
          'R\$ ${car.price}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1e2c4c),
          ),
        ),
      ],
    );
  }
}

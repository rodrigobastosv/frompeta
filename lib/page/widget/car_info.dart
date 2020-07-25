import 'package:flutter/material.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/utils/extensions.dart';

class CarInfo extends StatelessWidget {
  CarInfo(this.car);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        RichText(
          maxLines: 1,
          text: TextSpan(
            style: TextStyle(
              letterSpacing: -0.5,
              color: const Color(0xFF4b5670),
              fontWeight: FontWeight.bold,
              fontFamily: 'CircularStd',
            ),
            children: [
              TextSpan(
                text: '${car.brandName.toUpperCase()}',
              ),
              TextSpan(
                text: ' ${car.modelName.toUpperCase()}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${car.modelYear} · ${car.fuelType}',
          style: const TextStyle(
            color: Color(0xFF768095),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${car.transmissionType} · ${car.mileage.toString().formatNumber()} km',
          style: const TextStyle(
            color: Color(0xFF768095),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'R\$ ${car.price.toString().formatCurrency()}',
          style: TextStyle(
            color: const Color(0xFF1e2c4c),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

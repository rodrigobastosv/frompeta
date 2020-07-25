import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/model/car_model.dart';
import 'package:flutterdryve/utils/extensions.dart';

class CarInfoPage extends StatelessWidget {
  CarInfoPage(this.car);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: RichText(
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: car.id,
              child: Image.network(car.imageUrl),
            ),
            Wrap(
              children: <Widget>[
                LabelValue(label: 'Marca', value: car.brandName),
                LabelValue(label: 'Modelo', value: car.modelName),
                LabelValue(
                    label: 'Cor', value: getColorName(context, car.colorId)),
                LabelValue(label: 'Combustível', value: car.fuelType),
                LabelValue(label: 'Transmissão', value: car.transmissionType),
                LabelValue(
                    label: 'KM', value: car.mileage.toString().formatNumber()),
                LabelValue(label: 'Ano', value: car.modelYear.toString()),
                LabelValue(
                    label: 'Preço',
                    value: car.price.toString().formatCurrency()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getColorName(BuildContext context, int colorId) {
    final allColors = context.bloc<CarsFeedCubit>().allColors;
    final color =
        allColors.firstWhere((color) => color.colorId == colorId.toString());
    return color?.name;
  }
}

class LabelValue extends StatelessWidget {
  LabelValue({@required this.label, @required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

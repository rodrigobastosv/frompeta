import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_state.dart';
import 'package:flutterdryve/model/car_model.dart';

import '../car_info_page.dart';

class CarImage extends StatelessWidget {
  CarImage(this.car);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<CarsFeedCubit>();
    return Stack(
      children: <Widget>[
        Center(
          child: Hero(
            tag: car.id,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.bloc<CarsFeedCubit>(),
                    child: CarInfoPage(car),
                  ),
                ),
              ),
              child: Container(
                key: const ValueKey('car-image'),
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(car.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () {
              final isCarFavorite = cubit.isCarFavorite(car);
              if (isCarFavorite) {
                cubit.unfavoriteCar(car.id);
              } else {
                cubit.favoriteCar(car.id);
              }
            },
            child: BlocBuilder<CarsFeedCubit, CarsFeedState>(
              builder: (_, state) {
                final isCarFavorite = cubit.isCarFavorite(car);
                return Icon(
                  isCarFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 26,
                  key: const ValueKey('favorite-icon'),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

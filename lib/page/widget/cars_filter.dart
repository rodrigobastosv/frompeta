import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_state.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';

import 'pick_brand.dart';
import 'pick_color.dart';

class CarsFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CarsFeedCubit, CarsFeedState>(
        buildWhen: (previous, current) => current is OpenedSlidingPanel,
        builder: (_, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 60),
            PickBrand(context.bloc<CarsFeedCubit>().allBrands),
            Divider(
              color: Colors.black.withOpacity(0.65),
              height: 40,
              indent: 20,
              endIndent: 20,
            ),
            PickColor(context.bloc<CarsFeedCubit>().allColors),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OutlineButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    key: const ValueKey('limpar-btn'),
                    onPressed: () =>
                        context.bloc<CarsFilterCubit>().clearFilters(),
                    child: Text(
                      'Limpar',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  FlatButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    key: const ValueKey('aplicar-btn'),
                    onPressed: () {
                      final brands =
                          context.bloc<CarsFilterCubit>().pickedBrands;
                      final colors =
                          context.bloc<CarsFilterCubit>().pickedColors;

                      context.bloc<CarsFeedCubit>().applyFiltersOnSearch(
                            brands: brands,
                            colors: colors,
                          );

                      context.bloc<CarsFeedCubit>().closeSlidingPanel();
                    },
                    child: Text(
                      'Aplicar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

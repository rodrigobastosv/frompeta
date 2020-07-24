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
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_down),
                onPressed: () =>
                    context.bloc<CarsFeedCubit>().closeSlidingPanel(),
              ),
              title: Text(
                'Filtrar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1e2c4c),
                ),
              ),
            ),
            PickBrand(context.bloc<CarsFeedCubit>().allBrands),
            Divider(),
            PickColor(context.bloc<CarsFeedCubit>().allColors),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      padding: const EdgeInsets.all(18),
                      onPressed: () =>
                          context.bloc<CarsFilterCubit>().clearFilters(),
                      child: Text(
                        'Limpar',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(18),
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
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

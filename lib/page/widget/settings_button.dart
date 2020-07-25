import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_state.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SettingsButton extends StatelessWidget {
  SettingsButton({this.panelController});

  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsFilterCubit, CarsFilterState>(
      builder: (_, state) => Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          key: const ValueKey('settings-btn'),
          icon: Badge(
            position: BadgePosition.topRight(),
            badgeContent: Text(
              context.bloc<CarsFilterCubit>().countFilters.toString(),
              key: const ValueKey('count-filters'),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            badgeColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.tune,
              color: Colors.grey[600],
              size: 28,
            ),
          ),
          onPressed: () {
            if (panelController.isPanelOpen) {
              panelController.close();
            } else {
              context.bloc<CarsFeedCubit>().openSlidingPanel();
              panelController.open();
            }
          },
        ),
      ),
    );
  }
}

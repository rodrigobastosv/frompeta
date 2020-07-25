import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/page/cars_feed_view.dart';
import 'package:flutterdryve/repository/abstract/cars_feed_repository.dart';
import 'package:flutterdryve/service/locator.dart';
import 'package:flutterdryve/service/shared_preferences_service.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CarsFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarsFeedCubit>(
          create: (_) => CarsFeedCubit(
            repository: context.repository<CarsFeedRepository>(),
            sharedPreferencesService: G<SharedPreferencesService>(),
          )..fetchAllInfo(),
        ),
        BlocProvider<CarsFilterCubit>(
          create: (_) => CarsFilterCubit(),
        ),
      ],
      child: CarsFeedView(
        panelController: PanelController(),
      ),
    );
  }
}

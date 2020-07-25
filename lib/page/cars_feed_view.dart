import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_state.dart';
import 'package:flutterdryve/page/widget/settings_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widget/cars_filter.dart';
import 'widget/cars_grid.dart';
import 'widget/filter_header.dart';

class CarsFeedView extends StatefulWidget {
  CarsFeedView({@required this.panelController});

  final PanelController panelController;

  @override
  _CarsFeedViewState createState() => _CarsFeedViewState();
}

class _CarsFeedViewState extends State<CarsFeedView> {
  PanelController get panelController => widget.panelController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
        ),
        title: Text(
          'VW Seminovos',
          style: TextStyle(
            letterSpacing: -0.5,
            color: const Color(0xFF4b5670),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          SettingsButton(panelController: panelController),
        ],
      ),
      body: BlocConsumer<CarsFeedCubit, CarsFeedState>(
        listenWhen: (previous, current) => current is ClosedSlidingPanel,
        listener: (_, state) => panelController.close(),
        buildWhen: (previous, current) =>
            current is! OpenedSlidingPanel &&
            current is! ClosedSlidingPanel &&
            current is! CarFavorited &&
            current is! CarUnfavorited,
        builder: (_, state) {
          if (state is FetchInfoSuccess) {
            return SlidingUpPanel(
              defaultPanelState: PanelState.CLOSED,
              controller: panelController,
              backdropEnabled: true,
              minHeight: 0,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              header: FilterHeader(),
              panel: CarsFilter(),
              body: CarsGrid(cars: state.cars),
            );
          } else if (state is CarsFiltered) {
            return SlidingUpPanel(
              defaultPanelState: PanelState.CLOSED,
              controller: panelController,
              backdropEnabled: true,
              minHeight: 0,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              header: FilterHeader(),
              panel: CarsFilter(),
              body: CarsGrid(cars: state.cars),
            );
          } else if (state is LoadingInfo) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Um erro ocorreu!'),
            );
          }
        },
      ),
    );
  }
}

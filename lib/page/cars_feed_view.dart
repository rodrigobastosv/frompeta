import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_state.dart';
import 'package:flutterdryve/page/widget/settings_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widget/cars_filter.dart';
import 'widget/cars_grid.dart';

class CarsFeedView extends StatefulWidget {
  @override
  _CarsFeedViewState createState() => _CarsFeedViewState();
}

class _CarsFeedViewState extends State<CarsFeedView> {
  PanelController panelController;

  @override
  void initState() {
    panelController = PanelController();
    super.initState();
  }

  @override
  void dispose() {
    panelController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
        ),
        title: Text(
          'VW Seminovos',
          style: TextStyle(
            letterSpacing: -0.5,
            color: Color(0xFF4b5670),
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
            current is! OpenedSlidingPanel && current is! ClosedSlidingPanel,
        builder: (_, state) {
          if (state is FetchInfoSuccess) {
            return SlidingUpPanel(
              defaultPanelState: PanelState.CLOSED,
              controller: panelController,
              backdropEnabled: true,
              minHeight: 0,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              header: _buildHeader(),
              panel: CarsFilter(),
              body: CarsGrid(cars: state.cars),
            );
          } else if (state is CarsFiltered) {
            return SlidingUpPanel(
              defaultPanelState: PanelState.CLOSED,
              controller: panelController,
              backdropEnabled: true,
              minHeight: 0,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              header: _buildHeader(),
              panel: CarsFilter(),
              body: CarsGrid(cars: state.cars),
            );
          } else if (state is LoadingInfo) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Deu ruim'),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 36,
              color: Colors.black.withOpacity(0.25),
            ),
            onPressed: () => context.bloc<CarsFeedCubit>().closeSlidingPanel(),
          ),
          Expanded(
            child: Text(
              'Filtrar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1e2c4c),
              ),
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }
}

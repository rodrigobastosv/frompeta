import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';

class FilterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            key: const ValueKey('close-sliding'),
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
                color: const Color(0xFF1e2c4c),
              ),
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_state.dart';
import 'package:flutterdryve/model/color_model.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class PickColor extends StatelessWidget {
  PickColor(this.colors);

  final List<ColorModel> colors;

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<CarsFilterCubit>();
    return BlocBuilder<CarsFilterCubit, CarsFilterState>(
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                'Cor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1e2c4c),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 20,
                children: colors.map(
                  (color) {
                    return ColorTile(
                      key: UniqueKey(),
                      color: color,
                      value: cubit.isColorPicked(color),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ColorTile extends StatelessWidget {
  ColorTile({Key key, this.color, this.value = false}) : super(key: key);

  final ColorModel color;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RoundCheckBox(
            size: 30,
            borderColor:
                value ? const Color(0xFF0065ff) : const Color(0xFFdddddd),
            isChecked: value,
            onTap: (value) {
              if (value) {
                context.bloc<CarsFilterCubit>().pickColor(color);
              } else {
                context.bloc<CarsFilterCubit>().unpickColor(color);
              }
            },
            checkedWidget: Icon(
              Icons.check,
              color: const Color(0xFF0065ff),
              size: 16,
            ),
            checkedColor: Theme.of(context).scaffoldBackgroundColor,
            uncheckedColor: Colors.yellow,
            uncheckedWidget: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _getColorFromColorId(color.colorId),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            color.name,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF768095),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorFromColorId(String colorId) {
    switch (colorId) {
      case '1':
        return Colors.transparent;
      case '2':
        return const Color(0xFFd8dae1);
      case '3':
        return Colors.black;
      case '4':
        return const Color(0xFFfc4a40);
      default:
        return Colors.white;
    }
  }
}

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
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                'Cor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1e2c4c),
                ),
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              direction: Axis.horizontal,
              runSpacing: 1,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RoundCheckBox(
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
            color: Colors.blue,
          ),
          checkedColor: Theme.of(context).scaffoldBackgroundColor,
          uncheckedColor: Colors.yellow,
          uncheckedWidget: Container(
            color: _getColorFromColorId(color.colorId),
          ),
        ),
        SizedBox(width: 8),
        Text(color.name),
        SizedBox(width: 45),
      ],
    );
  }

  Color _getColorFromColorId(String colorId) {
    switch (colorId) {
      case '1':
        return Colors.transparent;
      case '2':
        return Colors.grey;
      case '3':
        return Colors.black;
      case '4':
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}

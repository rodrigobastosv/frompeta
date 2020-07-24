import 'package:equatable/equatable.dart';

class ColorModel extends Equatable {
  final String colorId;
  final String name;

  ColorModel({
    this.colorId,
    this.name,
  });

  static ColorModel fromJson(Map<String, dynamic> json) {
    return ColorModel(
      colorId: json['color_id'],
      name: json['name'],
    );
  }

  @override
  List<Object> get props => [colorId];
}

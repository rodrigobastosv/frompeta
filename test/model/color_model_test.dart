import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/model/color_model.dart';

void main() {
  test('fromJson', () {
    var json = {
      'color_id': '1',
      'name': 'Azul',
    };
    expect(
      ColorModel(
        colorId: '1',
        name: 'Azul',
      ),
      ColorModel.fromJson(json),
    );
  });
}

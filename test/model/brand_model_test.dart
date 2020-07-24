import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/model/brand_model.dart';

void main() {
  test('fromJson', () {
    var json = {
      'brand_id': '1',
      'name': 'Audi',
    };
    expect(
      BrandModel(
        brandId: '1',
        name: 'Audi',
      ),
      BrandModel.fromJson(json),
    );
  });
}

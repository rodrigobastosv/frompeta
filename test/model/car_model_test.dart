import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/model/car_model.dart';

void main() {
  test('fromJson', () {
    var json = {
      'id': '1',
      'color_id': 1,
      'brand_id': 1,
      'brand_name': 'Audi',
      'fuel_type': 'fuel',
      'image_url': 'image',
      'mileage': 1000,
      'model_name': 'V3',
      'model_year': 2020,
      'price': 90000,
      'transmission_type': 'Manual',
    };
    expect(
      CarModel(
        id: '1',
        colorId: 1,
        brandId: 1,
        brandName: 'Audi',
        fuelType: 'fuel',
        imageUrl: 'image',
        mileage: 1000,
        modelName: 'V3',
        modelYear: 2020,
        price: 90000,
        transmissionType: 'Manual',
      ),
      CarModel.fromJson(json),
    );
  });
}

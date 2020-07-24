import 'package:equatable/equatable.dart';

class CarModel extends Equatable {
  final String id;
  final String imageUrl;
  final String brandName;
  final String modelName;
  final int modelYear;
  final String fuelType;
  final int mileage;
  final String transmissionType;
  final int price;
  final int brandId;
  final int colorId;

  CarModel({
    this.id,
    this.imageUrl,
    this.brandName,
    this.modelName,
    this.modelYear,
    this.fuelType,
    this.mileage,
    this.transmissionType,
    this.price,
    this.brandId,
    this.colorId,
  });

  static CarModel fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      imageUrl: json['image_url'],
      brandName: json['brand_name'],
      modelName: json['model_name'],
      modelYear: json['model_year'],
      fuelType: json['fuel_type'],
      mileage: json['mileage'],
      transmissionType: json['transmission_type'],
      price: json['price'],
      brandId: json['brand_id'],
      colorId: json['color_id'],
    );
  }

  @override
  List<Object> get props => [id];
}

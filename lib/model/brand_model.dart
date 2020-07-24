import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  final String brandId;
  final String name;

  BrandModel({
    this.brandId,
    this.name,
  });

  static BrandModel fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandId: json['brand_id'],
      name: json['name'],
    );
  }

  @override
  List<Object> get props => [brandId];
}

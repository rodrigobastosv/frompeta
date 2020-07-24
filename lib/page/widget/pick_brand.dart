import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_state.dart';
import 'package:flutterdryve/model/brand_model.dart';
import 'package:flutterdryve/utils/extensions.dart';

class PickBrand extends StatelessWidget {
  PickBrand(this.brands);

  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<CarsFilterCubit>();
    return BlocBuilder<CarsFilterCubit, CarsFilterState>(
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              'Marca',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1e2c4c),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Busca por nome...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, i) {
              final brand = brands[i];
              return CheckboxListTile(
                key: ValueKey(brand.brandId),
                controlAffinity: ListTileControlAffinity.leading,
                title: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          AssetImage(_getAssetByBrandId(brand.brandId)),
                      maxRadius: 20,
                    ),
                    SizedBox(width: 16),
                    Text(brand.name.capitalize()),
                  ],
                ),
                value: cubit.isBrandPicked(brand),
                onChanged: (value) {
                  if (value) {
                    cubit.pickBrand(brand);
                  } else {
                    cubit.unpickBrand(brand);
                  }
                },
              );
            },
            itemCount: brands.length,
          ),
        ],
      ),
    );
  }

  String _getAssetByBrandId(String brandId) {
    switch (brandId) {
      case '1':
        return 'assets/images/logo_audi.png';
      case '2':
        return 'assets/images/logo_chevrolet.png';
      case '3':
        return 'assets/images/logo_hyundai.png';
      default:
        return '';
    }
  }
}

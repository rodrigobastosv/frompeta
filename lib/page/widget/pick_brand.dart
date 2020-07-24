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
            padding: const EdgeInsets.only(left: 20),
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
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFd3d5dc)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFd3d5dc)),
                ),
                isDense: true,
                hintText: 'Busca por nome...',
                hintStyle: TextStyle(
                  color: Color(0xFF768095),
                  fontSize: 16,
                  letterSpacing: -0.2,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  size: 24,
                  color: Color(0xFFa5abb7),
                ),
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
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage(_getAssetByBrandId(brand.brandId)),
                    ),
                    SizedBox(width: 20),
                    Text(
                      brand.name.capitalize(),
                      style: TextStyle(
                        color: Color(0xFF768095),
                      ),
                    ),
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

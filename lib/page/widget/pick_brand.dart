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
    return BlocBuilder<CarsFilterCubit, CarsFilterState>(
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Marca',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1e2c4c),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (term) =>
                  context.bloc<CarsFilterCubit>().filterBrands(brands, term),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFd3d5dc)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFd3d5dc)),
                ),
                isDense: true,
                hintText: 'Busca por nome...',
                hintStyle: const TextStyle(
                  color: Color(0xFF768095),
                  fontSize: 16,
                  letterSpacing: -0.2,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  size: 24,
                  color: const Color(0xFFa5abb7),
                ),
              ),
            ),
          ),
          BlocBuilder<CarsFilterCubit, CarsFilterState>(
            builder: (_, state) {
              var brandsToList = [
                ...brands,
              ];
              if (state is BrandsFiltered) {
                brandsToList = state.brands;
              }
              if (brandsToList.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    final brand = brandsToList[i];
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
                          const SizedBox(width: 20),
                          Text(
                            brand.name.capitalize(),
                            style: const TextStyle(
                              color: Color(0xFF768095),
                            ),
                          ),
                        ],
                      ),
                      value:
                          context.bloc<CarsFilterCubit>().isBrandPicked(brand),
                      onChanged: (value) {
                        if (value) {
                          context.bloc<CarsFilterCubit>().pickBrand(brand);
                        } else {
                          context.bloc<CarsFilterCubit>().unpickBrand(brand);
                        }
                      },
                    );
                  },
                  itemCount: brandsToList.length,
                );
              } else {
                return const ListTile(
                  title: Text(
                    'Nenhuma marca encontrada...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },
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

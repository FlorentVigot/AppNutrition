import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuka/Detail.dart';
import 'package:yuka/Product.dart';

import '../Color.dart';
import '../navigationbar.dart';


class NutritionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product product = Product(
      barcode: '12345678',
      name: 'Petits pois et carottes',
      brands: <String>['Cassegrain'],
    );

    return Scaffold(
      body: SizedBox.expand(
        child: ProductHolder(
          product: product,
          child: Stack(
            children: <Widget>[
              ProductImage(),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 250.0,
                bottom: 0.0,
                child: ProductNutrition(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      color: AppColors.GRAY2,

    );
  }
}

class ProductNutrition extends StatelessWidget {
  const ProductNutrition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    );

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: borderRadius,
      ),
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitle(),
                ProductFields(),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ProductHolder extends InheritedWidget {
  final Product product;

  const ProductHolder({
    required this.product,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static ProductHolder? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductHolder>();
  }

  @override
  bool updateShouldNotify(ProductHolder old) => product != old.product;
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product? product = ProductHolder.of(context)?.product;

    if (product == null) {
      return SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(product.brands?.join(',') ?? ''),
        const SizedBox(
          height: 8.0,
        ),
        Text("Repère nutritionnels pour 100g",
          textAlign: TextAlign.right,
          style: TextStyle(
              fontWeight: FontWeight.normal,
            color: AppColors.BLACK.withOpacity(0.6)),
          ),
      ],
    );
  }
}






  class ProductFields extends StatelessWidget {
  const ProductFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  ProductField(
  label: 'Matières grasses / lipides',
  value: '0,8g Faible quantité',
  divider: true,
  ),
  ProductField(
  label: 'Acide gras saturés',
  value: '0,1g',
  divider: true,
  ),
  ProductField(
  label: 'Sucres',
  value: '5,2g',
  divider: true,
  ),ProductField(
  label: 'Sel',
  value: '0,75g',
  divider: true,
  ),


  ],
  );
  }
  }

  class NutritionField extends StatelessWidget {
      final String label;
      final String value;
      final bool divider;

  NutritionField({
      required this.label,
      required this.value,
      this.divider = true,
      });

  @override
  Widget build(BuildContext context) {
  return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
              Expanded(
                child: Text(label),
              ),
              Expanded(
                child: Text(
                value,
                textAlign: TextAlign.end,
                ),
              ),
              ],
              ),
              ),
              Divider(),
              ],
              );
              }
}



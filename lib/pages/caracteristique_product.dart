import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuka/Detail.dart';
import 'package:yuka/Product.dart';

import '../Color.dart';
import '../navigationbar.dart';


class CaracteristiqueScreen extends StatelessWidget {


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
                child: ProductCaracteristique(),
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

class ProductCaracteristique extends StatelessWidget {
  const ProductCaracteristique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    );

    return Positioned.fill(
      top: 300.0,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: borderRadius,
        ),
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitle(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ProductFields(),
                ],
              ),
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
        Text("Petit pois et carottes à l'étuvée avec garniture"),
      ],
    );
  }
}



class CaracteristiqueField extends StatelessWidget {
  final String label;
  CaracteristiqueField({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.GRAY1),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.BLUE,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
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
        CaracteristiqueField(label: 'Ingrédients'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ProductField(
                label: 'Légume',
                value: 'petit pois 41%, carottes 22%',
                divider: true,
              ),
              ProductField(
                label: 'Eau',
                value: '',
                divider: true,
              ),
              ProductField(
                label: 'Sucre',
                value: '',
                divider: true,
              ),
              ProductField(
                label: 'Garniture (2,5 %)',
                value: 'salade, oignon grelot',
                divider: true,
              ),
              ProductField(
                label: 'Sel',
                value: '',
                divider: true,
              ),
              ProductField(
                label: 'Aromes naturels',
                value: '',
                divider: false,
              ),
            ],
          ),
        ),
        CaracteristiqueField(label: 'Substances allergènes'),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Aucune',
                style: TextStyle(
                  color: AppColors.BLUE,
                  fontWeight: FontWeight.w700,
                ))),
        CaracteristiqueField(label: 'Additifs'),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Aucun',
                style: TextStyle(
                  color: AppColors.BLUE,
                  fontWeight: FontWeight.w700,
                ))),
      ],
    );
  }
}

class ProductField extends StatelessWidget {
  final String label;
  final String value;
  final bool divider;
  ProductField({
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
                // flex: 1,
                child: Text(
                  label,
                  style: TextStyle(
                      color: AppColors.BLUE, fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                // flex: 1,
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
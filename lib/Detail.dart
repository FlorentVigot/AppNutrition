import 'dart:developer';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuka/network/network_product.dart';
import 'package:yuka/res/app_images.dart';

import 'Color.dart';
import 'Product.dart';
import 'app_icons.dart';
import 'network/network_api.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

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
                child: ProductDetails(),
              )
            ],
          ),
        ),
      ),
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
      color: AppColors.YELLOW,

    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

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
                const SizedBox(
                  height: 10.0,
                ),
                ProductInfo(),
                const SizedBox(
                  height: 10.0,
                ),
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
        Text("Petit pois et carottes à l'étuvée avec garniture"),
      ],
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.GRAY2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProductInfoLine1(),
          Divider(),
          ProductInfoLine2(),
        ],
      ),
    );
  }
}

class ProductInfoLine1 extends StatelessWidget {
  const ProductInfoLine1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 45,
            child: ProductInfoNutriScore(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Expanded(
            flex: 55,
            child: ProductInfoNova(),
          ),
        ],
      ),
    );
  }
}

class ProductInfoNutriScore extends StatelessWidget {
  const ProductInfoNutriScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nutri-Score'),
        Image.asset(AppImages.nutriscoreA),
      ],
    );
  }
}

class ProductInfoNova extends StatelessWidget {
  const ProductInfoNova({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Groupe Nova'),
        Text('Lorem ipsum'),
      ],
    );
  }
}

class ProductInfoLine2 extends StatelessWidget {
  const ProductInfoLine2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('EcoScore'),
          Row(
            children: [
              Icon(AppIcons.ecoscore_a),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text('Impact environnemental'),
              ),
            ],
          )
        ],
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
        ProductField(
          label: 'Quantité',
          value: '200g',
          divider: true,
        ),
        ProductField(
          label: 'Vendu',
          value: 'France',
          divider: false,
        ),
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
                child: Text(label),
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
/* class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[

        ]
        ),
        body: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              fit:BoxFit.cover,

              image: NetworkImage(
                  ("https://assets.afcdn.com/teaser/20210617/1948__45_w900h1200c1.jpg"),
              ),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            color: AppColors.WHITE
            ),
          child: Column(
              children: <Widget>[
                Text(
                  "Petit pois et carotte",
                  style: TextStyle(color: AppColors.BLACK),

                ),
                Text(
                  "Cassegrin",
                  style: TextStyle(color: AppColors.GRAY2),
                ),
                Text(
                    "Petit pois et carotte l'étuvée avec garniture",
                  style: TextStyle(color: AppColors.BLACK),
                ),
              Container(
                color: AppColors.GRAY3,
                child: Text(
                    'Nutri-Score'
                ),
                  



          ),
                Row(
                  children: [
                    Text(
                        'Quantité'
                    ),
                    Text(
                      '200g (égouté 130g)'
                    )
                  ],
                  /*Row(
                    children: [
                      Text(
                          'Vendu'
                      ),
                      Text(
                          'France'
                      )
                    ],
                    */

                  ),

                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 8.0,
                          ),
                          child: Row(
                          mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(
                              width: 10.0,
                              ),
                              const Icon(
                              Icons.check,
                              ),
                              Text(
                              'Végétalien'.toUpperCase(),
                              ),
                            ],
                          ),

                          /* child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Icon(
                                Icons.close,
                              ),
                              Text(
                                'Végétarien'.toUpperCase(),
                              ),
                            ],
                          ), */
                        )
                      )
              ]
          ),
        ]
          )
    ),
    persistentFooterButtons: <Widget>[

    ]
    );
  }
}

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}


https://sharemycode.fr/2t3 */



// En entrée
// En entrée
abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final String barcode;

  FetchProductEvent(this.barcode);
}

// En sortie
abstract class ProductState {
  final Product? product;

  ProductState(this.product);
}

class InitialState extends ProductState {
  InitialState() : super(null);
}

class ProductAvailableState extends ProductState {
  ProductAvailableState(Product product) : super(product);
}

/*
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Donner la valeur initiale
  ProductBloc() : super(InitialState());

  void fetchProduct(String barcode) {
    add(FetchProductEvent(barcode));
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductEvent) {
      String barcode = event.barcode;

      // Requête
      // Requête
      NetworkProduct networkProduct = await OpenFoodFactsAPI(
        Dio(),
        baseUrl: 'https://api.formation-android.fr/v2/',
      ).findProduct(barcode: barcode);

      yield ProductAvailableState(Product(
        barcode: barcode,
        name: networkProduct.response!.name,
        brands: <String>['Cassegrain'],
      )
      );
    }
  }
}*/

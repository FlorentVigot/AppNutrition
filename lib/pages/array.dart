import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuka/Detail.dart';
import 'package:yuka/Product.dart';

import '../Color.dart';


class Array extends StatelessWidget {
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
                child: ProductArray(),
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
      color: AppColors.GRAY2,

    );
  }
}

class ProductArray extends StatelessWidget {
  const ProductArray({Key? key}) : super(key: key);

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
                ArrayFields(),

              ],
            ),
          ),
        ),
      ),
    );
  }
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



class CaracteristiqueLabels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.GRAY2,
    );

  }
}



  class ArrayFields extends StatelessWidget {
  const ArrayFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Table(
     border: TableBorder.all(),
     children: [
        TableRow(
          children: [
            Text(''),
            Text('Pour 100g'),
            Text('Par part'),
          ]),
       TableRow(
           children: [
             Text('Energie'),
             Text('293 kj'),
             Text('?'),
           ]),
       TableRow(
           children: [
             Text('Matiere grasses'),
             Text('0,8 g'),
             Text('?'),
           ]),TableRow(
           children: [
             Text('dont Acides gras saturés'),
             Text('0,1 g'),
             Text('?'),
           ]),TableRow(
           children: [
             Text('Glucides'),
             Text('8,4 g'),
             Text('?'),
           ]),TableRow(
           children: [
             Text('dont Sucres'),
             Text('5,2 g'),
             Text('?'),
           ]),TableRow(
           children: [
             Text('Fibres alimentaires'),
             Text('5,2 g'),
             Text('?'),
           ]),TableRow(
           children: [
             Text('Protéines'),
             Text('4,2 g'),
             Text('?'),
           ]),TableRow(
           children: [
             Text('Sel'),
             Text('0,75 g'),
             Text('?'),
           ]),TableRow(
           children: [
             Text('Sodium'),
             Text('0,295 g'),
             Text('?'),
           ]),








     ],
   );

  }
  }
 /* class MediumWidget extends StatelessWidget {
  final String name;
  final String quantity;
  final String part;
  final bool divider;

  MediumWidget({
  required this.name,
  required this.quantity,
  required this.part,
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
                  child: Text(name),
                  ),
                  Expanded(
                  child: Text(
                  quantity,
                  textAlign: TextAlign.end,
                  ),
                  ),
                  Expanded(
                  child: Text(
                  quantity,
                  textAlign: TextAlign.end,
                  ),
                  ),
                  Expanded(
                    child: Text(
                      quantity,
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
*/

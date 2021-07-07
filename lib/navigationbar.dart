import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuka/Detail.dart';

import 'package:yuka/app_icons.dart';
import 'package:yuka/main.dart';
import 'package:yuka/pages/table_product.dart';
import 'package:yuka/pages/caracteristique_product.dart';
import 'package:yuka/pages/nutrition_product.dart';

import 'Color.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  final List<Widget> navList = [
    DetailsScreen(),
    CaracteristiqueScreen(),
    NutritionScreen(),
    TableScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: this.selectedIndex,

      items: [
        BottomNavigationBarItem(
          icon: Icon(AppIcons.tab_barcode),
          label: "Fiche",
        ),
        BottomNavigationBarItem(
            icon: Icon(AppIcons.tab_fridge),
            label: "Caracteristiques"
        ),
        BottomNavigationBarItem(
            icon: Icon(AppIcons.tab_nutrition),
            label: "Nutrition"
        ),
        BottomNavigationBarItem(
            icon: Icon(AppIcons.tab_array),
            label: "Tableau"
        ),
      ],
      onTap: (int index) {
        this.onTapHandler(index);
      },
    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
      if (index == 1) {
        Navigator.of(context).push(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context)  => navList[index],
          ),
        );
      }
    });
  }

}
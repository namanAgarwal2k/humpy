import 'package:flutter/material.dart';
import 'package:humpy/models/category.dart';

import 'dummy_data.dart';

import 'widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Widget> _gridCategories =
      DUMMY_CATEGORIES.map((Category category) {
    return CategoryItem(category);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: _gridCategories.length,
      itemBuilder: (context, index) {
        return _gridCategories[index];
      },
    );
  }
}

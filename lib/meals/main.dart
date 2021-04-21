import 'package:flutter/material.dart';
import 'package:humpy/meals/widgets/meal_item.dart';
import 'package:humpy/models/category.dart';

import 'package:humpy/models/meal.dart';

class MealsScreen extends StatefulWidget {
  static const route = 'meals';

  final List<Meal> availableMeals;

  MealsScreen(this.availableMeals);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  Category category;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_loadedInitData) return;

    category = ModalRoute.of(context).settings.arguments as Category;
    displayedMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    _loadedInitData = true;
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            imageUrl: displayedMeals[index].imageUrl,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:humpy/settings/main.dart';
import 'package:humpy/tabs/main.dart';

import 'categories/main.dart';
import 'meal_detail/main.dart';
import 'meals/dummy_data.dart';
import 'meals/main.dart';
import 'models/meal.dart';

void main() => runApp(humpy());

class humpy extends StatefulWidget {
  @override
  _humpyState createState() => _humpyState();
}

class _humpyState extends State<humpy> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    setState(() {
      if (existingIndex > -1) {
        _favoriteMeals.removeAt(existingIndex);
      } else {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(220, 220, 200, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        MealsScreen.route: (ctx) => MealsScreen(_availableMeals),
        MealDetailScreen.route: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        SettingsScreen.route: (ctx) => SettingsScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}

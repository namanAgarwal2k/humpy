import 'package:flutter/material.dart';
import 'package:humpy/favourites/main.dart';
import 'package:humpy/models/meal.dart';

import '../tabs/drawer.dart';
import '../categories/main.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _screens;

  int _selectedIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _screens = [
      {
        'screen': CategoriesScreen(),
        'title': 'Meal Categories',
      },
      {
        'screen': FavoritesScreen(widget._favoriteMeals),
        'title': 'Favorite Meals',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedIndex]['title']),
      ),
      drawer: MealsDrawer(),
      body: _screens[_selectedIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedTab,
        backgroundColor: _theme.primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: _theme.accentColor,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: const Text('Categories'),
            backgroundColor: _theme.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: const Text('Favorites'),
            backgroundColor: _theme.primaryColor,
          ),
        ],
      ),
    );
  }
}

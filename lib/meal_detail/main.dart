import 'package:flutter/material.dart';
import 'package:humpy/models/meal.dart';

import '../meals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const route = 'meal-detail';

  final Function _toggleFavorite;
  final Function _isFavorite;

  MealDetailScreen(this._toggleFavorite, this._isFavorite);

  Widget buildSectionTitle(ThemeData _theme, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: _theme.textTheme.title.copyWith(color: Colors.black),
      ),
    );
  }

  Widget buildContainer({Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      width: 300,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final Meal meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(_theme, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: _theme.accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        meal.ingredients[index],
                      ),
                    ),
                  );
                },
              ),
            ),
            buildSectionTitle(_theme, 'Steps'),
            buildContainer(
              child: ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                          backgroundColor: _theme.appBarTheme.color,
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          _isFavorite(mealId) ? Icons.favorite : Icons.favorite_border,
          color: _theme.primaryColor,
        ),
        onPressed: () => _toggleFavorite(mealId),
      ),
    );
  }
}

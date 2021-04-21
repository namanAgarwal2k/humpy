import 'package:flutter/material.dart';

import '../settings/main.dart';

class MealsDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: _theme.accentColor,
            child: Text(
              'What\'s Cookin\'?',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: _theme.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          buildListTile(
            'Settings',
            Icons.settings,
            () => Navigator.of(context)
                .pushReplacementNamed(SettingsScreen.route),
          ),
        ],
      ),
    );
  }
}

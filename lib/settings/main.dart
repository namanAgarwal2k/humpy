import 'package:flutter/material.dart';

import '../tabs/drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const String route = 'settings';
  final Map<String, bool> _currentFilters;
  final Function _saveFilters;

  SettingsScreen(this._currentFilters, this._saveFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    super.initState();

    _glutenFree = widget._currentFilters['gluten'];
    _vegetarian = widget._currentFilters['vegetarian'];
    _vegan = widget._currentFilters['vegan'];
    _lactoseFree = widget._currentFilters['lactose'];
  }

  Widget buildListItem(
    String title,
    String subtitle,
    bool value,
    Function changed,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      subtitle: Text(subtitle),
      onChanged: changed,
    );
  }

  void _saveSettings() {
    final selectedFilters = {
      'gluten': _glutenFree,
      'lactose': _lactoseFree,
      'vegan': _vegan,
      'vegetarian': _vegetarian,
    };

    widget._saveFilters(selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MealsDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildListItem(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });

                    _saveSettings();
                  },
                ),
                buildListItem(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });

                    _saveSettings();
                  },
                ),
                buildListItem(
                  'Vegan',
                  'Only include vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });

                    _saveSettings();
                  },
                ),
                buildListItem(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });

                    _saveSettings();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

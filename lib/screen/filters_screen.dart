import 'dart:ffi';

import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Function saveFilter;
  final Map<String, bool> currentFilter;
  const FiltersScreen(
      {Key? key, required this.saveFilter, required this.currentFilter})
      : super(key: key);
  static const routeName = '/filters';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  void initState() {
    _glutenFree = widget.currentFilter['gluten'] as bool;
    _lactoseFree = widget.currentFilter['lactose'] as bool;
    _vegetarian = widget.currentFilter['vegetarian'] as bool;
    _vegan = widget.currentFilter['vegan'] as bool;
    super.initState();
  }

  Widget _buildSwitch(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: (value) => updateValue(value),
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilter(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitch(
                  'Gluten-free', 'Only include gluten-free meals.', _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitch('Lactose-free', 'Only include Lactose-free meals.',
                  _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildSwitch(
                  'Vegetarian', 'Only include vegetarian meals.', _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitch('Vegan', 'Only include vegan meals.', _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}

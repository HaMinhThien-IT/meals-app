import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../screen/favorites_screen.dart';
import '../screen/categories_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _page = [
    {'page': const CategoriesScreen(), 'title': 'Categories'},
    {'page': const FavoritesScreen(), 'title': 'Your Favorites'},
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_selectedPageIndex]['title']),
      ),
      drawer: const MainDrawer(),
      body: _page[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: 'Categories',
              icon: const Icon(Icons.category)),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: 'Favorites',
              icon: const Icon(Icons.star))
        ],
      ),
    );
  }
}

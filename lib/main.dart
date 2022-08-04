import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meals.dart';
import '../screen/filters_screen.dart';
import './screen/tabs_screen.dart';
import './screen/meal_detail_screen.dart';
import './screen/categories_screen.dart';
import './screen/category_meals_screen.dart';

import './router/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  void _setFilters(Map<String, bool> filterData) {
    print(filterData);
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DelisMeals',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.pink, secondary: Colors.amber),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodySmall: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleMedium: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              titleLarge: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const TabsScreen(),
        RoutesName.categoryMealsScreen: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              currentFilter: _filters,
              saveFilter: _setFilters,
            )
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   if(settings.name == '/meal-detail'){
      //     return
      //   }
      //   return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeals'),
      ),
      body: const Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum FilterOptions {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  FiltersNotifier()
      : super({
          FilterOptions.glutenFree: false,
          FilterOptions.lactoseFree: false,
          FilterOptions.vegetarian: false,
          FilterOptions.vegan: false,
        });

  void setFilter(FilterOptions filter, bool value) {
    state = {...state, filter: value};
  }

  void setFilters(Map<FilterOptions, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>(
        (ref) => FiltersNotifier()); // (1

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProviders);
  final filters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (filters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filters[FilterOptions.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});

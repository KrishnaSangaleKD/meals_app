import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifies extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifies() : super([]);
  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsRavorite = state.contains(meal);
    if (mealIsRavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifies, List<Meal>>((ref) {
  return FavoriteMealsNotifies();
});

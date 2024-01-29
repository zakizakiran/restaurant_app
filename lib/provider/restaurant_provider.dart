import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';

import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final restaurantListProvider = FutureProvider<List<Restaurant>>((ref) async {
  final apiService = RestaurantApiService();
  final List<Restaurant> restaurantList =
      await apiService.fetchRestaurantList();

  return restaurantList;
});

final restaurantSearchProvider = FutureProvider.autoDispose
    .family<List<Restaurant>, String>((ref, query) async {
  final apiService = RestaurantApiService();
  final List<Restaurant> searchResult =
      await apiService.fetchSearchRestaurant(query);

  return searchResult;
});

final restaurantDetailProvider = FutureProvider.autoDispose
    .family<RestaurantDetail, String>((ref, id) async {
  final apiService = RestaurantApiService();
  final RestaurantDetail restaurantDetail =
      await apiService.fetchRestaurantDetail(id);

  return restaurantDetail;
});

final favoriteRestaurantsProvider =
    FutureProvider<List<Restaurant>>((ref) async {
  final apiService = RestaurantApiService();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteIds =
      prefs.getKeys().where((key) => prefs.getBool(key) ?? false).toList();

  List<Restaurant> favoriteRestaurants = await Future.wait(
    favoriteIds.map((id) async {
      final restaurantDetail = await apiService.fetchRestaurantDetail(id);

      return Restaurant(
        id: restaurantDetail.id,
        name: restaurantDetail.name,
        city: restaurantDetail.city,
        description: restaurantDetail.description,
        pictureId: restaurantDetail.pictureId,
        rating: restaurantDetail.rating,
      );
    }),
  );

  return favoriteRestaurants;
});

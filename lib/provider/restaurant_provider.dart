import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/helper/database_helper.dart';

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
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> favoriteRestaurantsData =
      await dbHelper.getFavoriteRestaurants();

  List<Restaurant> favoriteRestaurants = [];

  try {
    favoriteRestaurants = await Future.wait(
      favoriteRestaurantsData.map((restaurantData) async {
        final restaurantDetail =
            await apiService.fetchRestaurantDetail(restaurantData['id']);

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
  } catch (error) {
    // Handle error if needed, e.g., log the error
    log('Error fetching favorite restaurant details: $error');
  }

  return favoriteRestaurants;
});

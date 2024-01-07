import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/restaurant_detail_model.dart';
import 'dart:convert';

import 'package:restaurant_app/models/restaurant_model.dart';

final restaurantListProvider = FutureProvider<List<Restaurant>>((ref) async {
  try {
    final response =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> rawList = data['restaurants'];

      List<Restaurant> restaurantList =
          rawList.map((json) => Restaurant.fromJson(json)).toList();

      return restaurantList;
    } else {
      throw Exception('Failed to load data - ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('No internet connection');
  } on http.ClientException {
    throw Exception('Failed to connect to the server.');
  } catch (e) {
    rethrow;
  }
});

final restaurantSearchProvider = FutureProvider.autoDispose
    .family<List<Restaurant>, String>((ref, query) async {
  try {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> rawList = data['restaurants'];

      List<Restaurant> searchResult =
          rawList.map((json) => Restaurant.fromJson(json)).toList();

      return searchResult;
    } else {
      throw Exception('Failed to search data - ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('No internet connection');
  } on http.ClientException {
    throw Exception('Failed to connect to the server.');
  } catch (e) {
    rethrow;
  }
});

final restaurantDetailProvider = FutureProvider.autoDispose
    .family<RestaurantDetail, String>((ref, id) async {
  try {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return RestaurantDetail.fromJson(jsonData['restaurant']);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  } on SocketException {
    throw Exception('No internet connection');
  } on http.ClientException {
    throw Exception('Failed to connect to the server.');
  } catch (e) {
    rethrow;
  }
});

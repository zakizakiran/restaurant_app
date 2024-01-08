import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';

class RestaurantApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<Restaurant>> fetchRestaurantList() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/list'));

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
  }

  Future<List<Restaurant>> fetchSearchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> rawList = data['restaurants'];

        List<Restaurant> searchResult =
            rawList.map((json) => Restaurant.fromJson(json)).toList();

        return searchResult;
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
  }

  Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

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
  }
}

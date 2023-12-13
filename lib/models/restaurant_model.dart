import 'dart:convert';
import 'package:flutter/services.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final List<Food> foods;
  final List<Drink> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    List<Food> foodsList = (json['menus']['foods'] as List)
        .map((food) => Food.fromJson(food))
        .toList();

    List<Drink> drinksList = (json['menus']['drinks'] as List)
        .map((drink) => Drink.fromJson(drink))
        .toList();

    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      foods: foodsList,
      drinks: drinksList,
    );
  }
}

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
    );
  }
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'],
    );
  }
}

class RestaurantService {
  static Future<List<Restaurant>> fetchData() async {
    String data =
        await rootBundle.loadString('assets/data/local_restaurant.json');
    final jsonData = json.decode(data)['restaurants'] as List<dynamic>;
    List<Restaurant> restaurants =
        jsonData.map((json) => Restaurant.fromJson(json)).toList();
    return restaurants;
  }
}

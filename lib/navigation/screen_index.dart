import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/pages/restaurant_favorite_page.dart';
import 'package:restaurant_app/pages/restaurant_list_page.dart';

List<Widget> screenIndex() {
  return [
    const RestaurantListPage(),
    const FavoriteRestaurantsList(),
  ];
}

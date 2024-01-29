import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';

import '../custom/restaurant_list_card.dart';

class RestaurantListWidget extends StatelessWidget {
  final List data;
  const RestaurantListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        Restaurant restaurant = data[index];
        return RestaurantListCard(restaurant: restaurant);
      },
    );
  }
}

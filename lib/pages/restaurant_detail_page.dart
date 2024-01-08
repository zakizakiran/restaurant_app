import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/common/restaurant_detail_widget.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, WidgetRef ref, _) {
        return Scaffold(body: RestaurantDetailWidget(id: widget.restaurantId));
      },
    );
  }
}

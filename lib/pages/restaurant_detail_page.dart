import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/common/restaurant_detail_widget.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, WidgetRef ref, _) {
        return Scaffold(body: RestaurantDetailWidget(id: restaurantId));
      },
    );
  }
}

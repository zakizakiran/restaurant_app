import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/custom/restaurant_list_card.dart'; // Update with your actual path

class FavoriteRestaurantsList extends ConsumerWidget {
  const FavoriteRestaurantsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteRestaurantsAsyncValue =
        ref.watch(favoriteRestaurantsProvider);

    return favoriteRestaurantsAsyncValue.when(
      data: (favoriteRestaurants) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Favorite Restaurants',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: favoriteRestaurants.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset('assets/img/empty-data.json',
                          width: MediaQuery.sizeOf(context).width / 1.5),
                    ),
                    const Text("You don't have any favorite restaurants"),
                  ],
                )
              : ListView.builder(
                  itemCount: favoriteRestaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    final restaurant = favoriteRestaurants[index];
                    return RestaurantListCard(restaurant: restaurant);
                  },
                ),
        );
      },
      loading: () => Center(
        child: Lottie.asset('assets/img/load.json'),
      ),
      error: (error, stackTrace) {
        if (error is Exception &&
            error.toString().contains('No internet connection')) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/img/no-internet.json',
                  width: MediaQuery.of(context).size.width / 2),
              const SizedBox(height: 16.0),
              const Center(child: Text('No internet connection')),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // ignore: unused_result
                  ref.refresh(favoriteRestaurantsProvider);
                },
                child: const Text('Refresh'),
              ),
            ],
          );
        }
        return Center(child: Text('Error: $error'));
      },
    );
  }
}

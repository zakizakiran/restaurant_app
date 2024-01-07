import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/provider/restaurant_service.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Consumer(
      builder: (context, WidgetRef ref, _) {
        AsyncValue<List<Restaurant>> restaurantList = ref.watch(
            searchController.text.isEmpty
                ? restaurantListProvider
                : restaurantSearchProvider(searchController.text));

        return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: SvgPicture.asset('assets/img/logo.svg', width: 100),
            ),
            body: Column(
              children: [
                SearchTextFieldWidget(
                    searchController: searchController, ref: ref),
                Expanded(
                  child:
                      _buildRestaurant(restaurantList, ref, searchController),
                ),
              ],
            ));
      },
    );
  }
}

Widget _buildRestaurant(AsyncValue<List<Restaurant>> restaurantList,
    WidgetRef ref, TextEditingController searchController) {
  return restaurantList.when(
    loading: () => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/img/load.json'),
        const SizedBox(height: 8.0),
        const Text('Please wait...'),
      ],
    ),
    error: (error, stackTrace) {
      if (error is Exception &&
          error.toString().contains('No internet connection')) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('No Internet Connection')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                restaurantList.isLoading
                    ? Lottie.asset('assets/img/load.json')
                    // ignore: unused_result
                    : ref.refresh(searchController.text.isEmpty
                        ? restaurantListProvider
                        : restaurantSearchProvider(searchController.text));
              },
              child: const Text('Refresh'),
            ),
          ],
        );
      }
      return Center(child: Text('Error: $error'));
    },
    data: (data) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          data.isEmpty
              ? const Center(
                  child: Text('Data Not Found.'),
                )
              : RestaurantListWidget(
                  data: data,
                ),
        ],
      );
    },
  );
}

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchController,
    required this.ref,
  });

  final TextEditingController searchController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          suffixIcon: searchController.text.isEmpty
              ? IconButton(
                  onPressed: () {
                    ref.watch(restaurantSearchProvider(searchController.text));
                  },
                  icon: const Icon(Icons.search),
                )
              : IconButton(
                  onPressed: () {
                    searchController.clear();
                    ref.watch(restaurantSearchProvider(searchController.text));
                  },
                  icon: const Icon(CupertinoIcons.xmark),
                ),
        ),
        controller: searchController,
        onChanged: (value) {
          ref.watch(restaurantSearchProvider(value));
        },
      ),
    );
  }
}

class RestaurantListWidget extends StatelessWidget {
  final List data;
  const RestaurantListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          Restaurant restaurant = data[index];
          return RestaurantListCard(restaurant: restaurant);
        },
      ),
    );
  }
}

class RestaurantListCard extends StatelessWidget {
  const RestaurantListCard({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantDetailPage(
                      restaurantId: restaurant.id,
                    )));
      },
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                      width: 120,
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        restaurant.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        restaurant.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location_solid,
                          size: 15,
                          color: HexColor('F64363'),
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          restaurant.city,
                          style: const TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          size: 20,
                          color: HexColor('F9C338'),
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import '../widget/common/restaurant_list_widget.dart';
import '../widget/custom/search_text_field_widget.dart';

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

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: SvgPicture.asset('assets/img/logo.svg', width: 100),
            ),
            body: Column(
              children: [
                SearchTextFieldWidget(
                    searchController: searchController, ref: ref),
                Expanded(
                  child: _buildRestaurant(
                      context, restaurantList, ref, searchController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildRestaurant(
    BuildContext context,
    AsyncValue<List<Restaurant>> restaurantList,
    WidgetRef ref,
    TextEditingController searchController) {
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
            Lottie.asset('assets/img/no-internet.json',
                width: MediaQuery.of(context).size.width / 2),
            const Center(child: Text('No internet connection')),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                restaurantList.isLoading
                    ? Lottie.asset('assets/img/no-internet.json')
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
      return data.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/img/not-found.json',
                    width: MediaQuery.of(context).size.width / 2),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const Center(
                    child: Text(
                      "Sorry, we couldn't find any results for your search",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          : RestaurantListWidget(
              data: data,
            );
    },
  );
}

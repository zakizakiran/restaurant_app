import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

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

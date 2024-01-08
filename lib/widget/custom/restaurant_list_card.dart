import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:restaurant_app/data/models/restaurant_model.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';

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

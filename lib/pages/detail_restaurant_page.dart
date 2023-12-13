import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/models/restaurant_model.dart';

class DetailRestaurantPage extends StatefulWidget {
  final Restaurant restaurant;

  const DetailRestaurantPage({super.key, required this.restaurant});

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  bool isLoved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              surfaceTintColor: HexColor('F64363'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      backgroundColor: HexColor('F64363')),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: const Text(''),
                ),
              ),
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Image.network(
                      widget.restaurant.pictureId,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15.0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.restaurant.name,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location_solid,
                                  size: 15.0,
                                  color: HexColor('F64363'),
                                ),
                                const SizedBox(width: 5.0),
                                Text(widget.restaurant.city),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.star_fill,
                                  size: 15.0,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 5.0),
                                Text(widget.restaurant.rating.toString())
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            isLoved ? Icons.favorite : Icons.favorite_border,
                            color: isLoved ? HexColor('F64363') : null,
                          ),
                          onPressed: () {
                            setState(() {
                              isLoved = !isLoved;
                            });
                          },
                        )
                      ],
                    ),
                    ReadMoreText(
                      widget.restaurant.description,
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Less',
                      moreStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: HexColor(
                          'F64363',
                        ),
                      ),
                      lessStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: HexColor(
                          'F64363',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Foods',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.food_bank_outlined,
                      color: HexColor('F64363'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.restaurant.foods.length,
                  itemBuilder: (BuildContext context, int index) {
                    final food = widget.restaurant.foods[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Card(
                          color: HexColor('F3E7E9'),
                          child: Center(
                            child: Text(
                              food.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: HexColor('F64363'),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Drinks',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.wine_bar_outlined,
                      color: HexColor('F64363'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.restaurant.drinks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final drink = widget.restaurant.drinks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Card(
                          color: HexColor('F3E7E9'),
                          child: Center(
                            child: Text(
                              drink.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor('F64363'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

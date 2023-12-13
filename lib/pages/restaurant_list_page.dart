import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.all(10.0),
          title: SvgPicture.asset(
            'assets/img/logo.svg',
            width: MediaQuery.of(context).size.width / 4,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Find restaurant name',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('F64363'))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('F64363'))),
                  prefixIcon: Icon(
                    Icons.search,
                    color: HexColor('F64363'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                  future: RestaurantService.fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> jsonData = snapshot.data!;
                      List<dynamic> restaurantData = jsonData['restaurants'];
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: restaurantData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailRestaurantPage(
                                              restaurant:
                                                  restaurantData[index])));
                            },
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              margin: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: restaurantData[index]['pictureId'],
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.network(
                                            restaurantData[index]['pictureId'],
                                            width: 120,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurantData[index]['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5.0),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Text(
                                              restaurantData[index]
                                                  ['description'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  fontSize: 12.0),
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
                                                restaurantData[index]['city'],
                                                style: const TextStyle(
                                                    fontSize: 12.0),
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
                                                restaurantData[index]['rating']
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12.0),
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
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error fetching data'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_vehicle_planner/components/seeAll.dart';
import 'package:travel_vehicle_planner/tabs/tp/const.dart';
import 'package:travel_vehicle_planner/tabs/tp/pages/place_detail.dart';
import 'package:travel_vehicle_planner/tabs/tp/widgets/popular_place.dart';
import 'package:travel_vehicle_planner/tabs/tp/widgets/recomendate.dart';

import '../models/travel_model.dart';

class TravelHomeScreen extends StatefulWidget {
  const TravelHomeScreen({super.key});

  @override
  State<TravelHomeScreen> createState() => _TravelHomeScreenState();
}

class _TravelHomeScreenState extends State<TravelHomeScreen> {
  int selectedPage = 0;
  List<IconData> icons = [
    Iconsax.home1,
    Iconsax.search_normal,
    Icons.confirmation_number_outlined,
    Icons.bookmark_outline,
    Icons.person_outline,
  ];

  List<TravelDestination> popular = myDestination.where((element) => element.category == "popular").toList();
  List<TravelDestination> recomendate = myDestination.where((element) => element.category == "recomend").toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // appBar: headerParts(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Places",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SeeAllPage(pagename: "place",which: "Popular",)));
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 14,
                          color: blueTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  children: List.generate(
                    popular.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlaceDetailScreen(
                                destination: popular[index],
                              ),
                            ),
                          );
                        },
                        child: PopularPlace(
                          destination: popular[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommendations for You",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SeeAllPage(pagename: "place",which: "Recomended",)));   
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 14,
                          color: blueTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: List.generate(
                    recomendate.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlaceDetailScreen(
                                destination: recomendate[index],
                              ),
                            ),
                          );
                        },
                        child: Recomendate(
                          destination: recomendate[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}

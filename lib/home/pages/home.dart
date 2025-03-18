import 'dart:math';
import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/constant/baseurl/baseurl.dart';
import 'package:travel_vehicle_planner/home/components/about_hotel.dart';
import 'package:travel_vehicle_planner/home/components/about_travel.dart';
import 'package:travel_vehicle_planner/home/components/about_vehicle.dart';
import 'package:travel_vehicle_planner/home/components/curve_app_bar.dart';
import 'package:travel_vehicle_planner/home/models/services.dart';
import 'package:travel_vehicle_planner/hotel/models/hotel_model.dart';
import 'package:travel_vehicle_planner/tp/models/travel_model.dart';
import 'package:travel_vehicle_planner/vehicle/models/vehicle_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController controller;
  double pageoffSet = 1;
  int currentIndex = 0;

  bool travel = true;
  bool hotels = false;
  bool vehicles = false;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 1000, // Large initial page for looping
      viewportFraction: 0.6,
    )..addListener(() {
        setState(() {
          pageoffSet = controller.page!;
        });
      });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (myDestination.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No destinations available")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: ClipPath(
          clipper: CurveAppBar(),
          child: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            title: const Text('Home'),
            centerTitle: true,
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.person))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(bottom: 5),
                child: const Text('Our Services',style: TextStyle(color: Colors.black,fontSize: 19),)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                   travel = true;
                   vehicles = false;
                   hotels = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: travel == true ? Colors.grey[400]:Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    '${baseurlHomePage}travel.png',
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Travel',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
                    ),
            Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                   travel = false;
                   vehicles = false;
                   hotels = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: hotels == true ? Colors.grey[400]:Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    '${baseurlHomePage}hotel.png',
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hotels',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
                    ),
            Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                   travel = false;
                   vehicles = true;
                   hotels = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: vehicles == true ? Colors.grey[400]:Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    '${baseurlHomePage}vehicles.png',
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Vehicles',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
                    ),
            ],),
          ),
          const SizedBox(height: 10,),
          if(travel)...[   
            TravelContainer(),       
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: controller,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index % myDestination.length;
                          });
                        },
                        itemCount: null, // will handle infinite loop manually
                        itemBuilder: (context, index) {
                          int wrappedIndex = index % myDestination.length;

                          final destination = myDestination[wrappedIndex];

                          if (destination.image != null && destination.image!.isNotEmpty) {
                            double scale = max(
                              0.6,
                              (1 - (pageoffSet - index).abs() + 0.6),
                            );
                            double angle = (controller.position.haveDimensions
                                    ? index.toDouble() - (controller.page ?? 0)
                                    : index.toDouble() - 1) *
                                5;
                            angle = angle.clamp(-5, 5);

                            return GestureDetector(
                              onTap: () {
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 100 - (scale / 1.6 * 100),
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Transform.rotate(
                                      angle: angle * pi / 90,
                                      child: Hero(
                                        tag: destination.price,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.asset(
                                            destination.image![wrappedIndex % destination.image!.length],
                                            height: 250,
                                            width: 180,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      Positioned(
                        top: 330,
                        child: Row(
                          children: List.generate(
                            myDestination.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 15),
                              width: currentIndex == index ? 30 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.black
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),],
          if(hotels)...[
            HotelContainer(),
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: controller,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index % hotelDestination.length;
                          });
                        },
                        itemCount: null, // will handle infinite loop manually
                        itemBuilder: (context, index) {
                          int wrappedIndex = index % hotelDestination.length;

                          final destination = hotelDestination[wrappedIndex];

                          if (destination.image != null && destination.image!.isNotEmpty) {
                            double scale = max(
                              0.6,
                              (1 - (pageoffSet - index).abs() + 0.6),
                            );
                            double angle = (controller.position.haveDimensions
                                    ? index.toDouble() - (controller.page ?? 0)
                                    : index.toDouble() - 1) *
                                5;
                            angle = angle.clamp(-5, 5);

                            return GestureDetector(
                              onTap: () {
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 100 - (scale / 1.6 * 100),
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Transform.rotate(
                                      angle: angle * pi / 90,
                                      child: Hero(
                                        tag: destination.price,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.asset(
                                            destination.image![wrappedIndex % destination.image!.length],
                                            height: 250,
                                            width: 180,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      Positioned(
                        top: 330,
                        child: Row(
                          children: List.generate(
                            hotelDestination.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 15),
                              width: currentIndex == index ? 30 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.black
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          ],
          if(vehicles)...[
            VehicleBookingContainer(),
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: controller,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index % vehiclesList.length;
                          });
                        },
                        itemCount: null, // will handle infinite loop manually
                        itemBuilder: (context, index) {
                          int wrappedIndex = index % vehiclesList.length;

                          final destination = vehiclesList[wrappedIndex];

                          if (destination.image != null && destination.image!.isNotEmpty) {
                            double scale = max(
                              0.6,
                              (1 - (pageoffSet - index).abs() + 0.6),
                            );
                            double angle = (controller.position.haveDimensions
                                    ? index.toDouble() - (controller.page ?? 0)
                                    : index.toDouble() - 1) *
                                5;
                            angle = angle.clamp(-5, 5);

                            return GestureDetector(
                              onTap: () {
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 100 - (scale / 1.6 * 100),
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Transform.rotate(
                                      angle: angle * pi / 90,
                                      child: Hero(
                                        tag: destination.price,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.asset(
                                            destination.image![wrappedIndex % destination.image!.length],
                                            height: 250,
                                            width: 180,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      Positioned(
                        top: 330,
                        child: Row(
                          children: List.generate(
                            vehiclesList.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 15),
                              width: currentIndex == index ? 30 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.black
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          ]
        
        ],
      ),
    );
  }
Row servicesItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        services.length,
        (index) => Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  // Reset all flags to false first
                  travel = false;
                  hotels = false;
                  vehicles = false;

                  // Set the clicked flag to true based on the service name
                  if (services[index].name == 'Travel') {
                    travel = true;
                    hotels = false;
                    vehicles = false;
                  } else if (services[index].name == 'Hotels') {
                    hotels = true;
                    travel = false;
                    vehicles = false;
                  } else if (services[index].name == 'Vehicles') {
                    hotels = false;
                    travel = false;
                    vehicles = true;
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: _getColorForService(services[index].name), // Get color based on the service type
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  services[index].icon,
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              services[index].name,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForService(String serviceName) {
    if (serviceName == 'Travel' && travel) {
      return Colors.black; // Set color to black if 'travel' is true
    } else if (serviceName == 'Hotels' && hotels) {
      return Colors.black; // Set color to black if 'hotels' is true
    } else if (serviceName == 'Vehicles' && vehicles) {
      return Colors.black; // Set color to black if 'vehicles' is true
    } else {
      return Colors.grey[100]!; // Default color (light grey)
    }
  }
}

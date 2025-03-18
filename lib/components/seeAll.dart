import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/hotel/components/recomend.dart';
import 'package:travel_vehicle_planner/hotel/models/hotel_model.dart';
import 'package:travel_vehicle_planner/hotel/pages/hotel_details.dart';
import 'package:travel_vehicle_planner/tp/const.dart';
import 'package:travel_vehicle_planner/tp/models/travel_model.dart';
import 'package:travel_vehicle_planner/tp/pages/place_detail.dart';
import 'package:travel_vehicle_planner/tp/widgets/recomendate.dart';
import 'package:travel_vehicle_planner/vehicle/components/recomend_vehicle.dart';
import 'package:travel_vehicle_planner/vehicle/models/vehicle_model.dart';
import 'package:travel_vehicle_planner/vehicle/pages/vehicle_details.dart';

class SeeAllPage extends StatefulWidget {
  final String pagename;
  final String which;

  const SeeAllPage({super.key, required this.pagename, required this.which});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  List<VehicleModel> popularVehicles = [];
  List<VehicleModel> recomendateVehicles = [];
  List<TravelDestination> popularPlaces = [];
  List<TravelDestination> recomendatePlaces = [];
  List<HotelDestination> popularHotels = [];
  List<HotelDestination> recomendateHotels = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    // Handle places
    if (widget.pagename == 'place') {
      if (widget.which == 'Popular') {
        popularPlaces = myDestination.where((element) => element.category == "popular").toList();
      } else if (widget.which == 'Recomended') {
        recomendatePlaces = myDestination.where((element) => element.category == "recomend").toList();
      }
    }

    // Handle vehicles
    if (widget.pagename == 'vehicle') {
      if (widget.which == 'Popular') {
        popularVehicles = vehiclesList.where((element) => element.category == "popular").toList();
      } else if (widget.which == 'Recomended') {
        recomendateVehicles = vehiclesList.where((element) => element.category == "recomend").toList();
      }
    }

    // Handle hotels
    if (widget.pagename == 'hotel') {
      if (widget.which == 'Popular') {
        popularHotels = hotelDestination.where((element) => element.category == "popular").toList();
      } else if (widget.which == 'Recomended') {
        recomendateHotels = hotelDestination.where((element) => element.category == "recomend").toList();
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(
                      "${widget.which} ${widget.pagename}s",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
        leadingWidth: 64,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: List.generate(
                    widget.pagename == 'vehicle'
                        ? (widget.which == "Recomended" ? recomendateVehicles.length : popularVehicles.length)
                        : widget.pagename == 'hotel'
                            ? (widget.which == "Recomended" ? recomendateHotels.length : popularHotels.length)
                            : (widget.which == "Recomended" ? recomendatePlaces.length : popularPlaces.length),
                    (index) {
                      if (widget.pagename == 'vehicle') {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VehicleDetailScreen(
                                    vehicleModel: widget.which == 'Recomended'
                                        ? recomendateVehicles[index]
                                        : popularVehicles[index],
                                  ),
                                ),
                              );
                            },
                            child: widget.which == "Recomended"
                                ? RecomendVehicle(model: recomendateVehicles[index])
                                : RecomendVehicle(model: popularVehicles[index]),
                          ),
                        );
                      } else if (widget.pagename == 'hotel') {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HotelDetailScreen(
                                    hotel: widget.which == 'Recomended'
                                        ? recomendateHotels[index]
                                        : popularHotels[index],
                                  ),
                                ),
                              );
                            },
                            child: widget.which == "Recomended"
                                ? RecomendHotel(hotel: recomendateHotels[index])
                                : RecomendHotel(hotel: popularHotels[index]),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PlaceDetailScreen(
                                    destination: widget.which == 'Recomended'
                                        ? recomendatePlaces[index]
                                        : popularPlaces[index],
                                  ),
                                ),
                              );                            },
                            child: widget.which == "Recomended"
                                ? Recomendate(destination: recomendatePlaces[index])
                                : Recomendate(destination: popularPlaces[index]),
                          ),
                        );
                      }
                    },
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

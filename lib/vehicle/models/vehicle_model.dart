import 'dart:math';

import 'package:travel_vehicle_planner/constant/baseurl/baseurl.dart';

Random random = Random();

class VehicleModel {
  final int id, price, review;
  final List<String>? image;
  final String name, description, category, location,type;
  final double rate;

  VehicleModel({
    required this.name,
    required this.price,
    required this.id,
    required this.category,
    required this.description,
    required this.review,
    required this.image,
    required this.rate,
    required this.location,
    required this.type,
  });
}

List<VehicleModel> vehiclesList = [
  VehicleModel(
    id: 2,
    name: "Golden e bikes",
    category: 'popular',
    image: [
      "${baseurlVehiclePopular}hampi-1.jpg",
      "${baseurlVehiclePopular}hampi-2.jpg",
      "${baseurlVehiclePopular}hampi-3.jpg",
      "${baseurlVehiclePopular}hampi-1.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "two-wheeler"
  ),
  VehicleModel(
    id: 7,
    price: 5000,
    name: "Revv Self Drive Car Rental",
    image: [
      "${baseurlVehiclePopular}mysore-1.jpg",
      "${baseurlVehiclePopular}mysore-2.jpg",
      "${baseurlVehiclePopular}mysore-3.JPG",
      "${baseurlVehiclePopular}mysore-4.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'four-wheeler'
  ),
  VehicleModel(
    id: 3,
    name: "Bright Bike Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlVehicleRecomend}chikmangaluru-1.jpg",
      "${baseurlVehicleRecomend}chikmangaluru-2.jpg",
      "${baseurlVehicleRecomend}chikmangaluru-3.jpg",
      "${baseurlVehicleRecomend}chikmangaluru-4.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "two-wheeler"
  ),
  VehicleModel(
    id: 8,
    name: "Aditya Car Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlVehiclePopular}uttarakannada-1.jpg",
      "${baseurlVehiclePopular}uttarakannada-2.jpg",
      "${baseurlVehiclePopular}uttarakannada-1.jpg",
      "${baseurlVehiclePopular}uttarakannada-2.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "four-wheeler"
  ),
  VehicleModel(
    id: 1,
    name: "Bike Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlVehicleRecomend}shimogga-1.jpg",
      "${baseurlVehicleRecomend}shimogga-2.jpg",
      "${baseurlVehicleRecomend}shimogga-3.jpg",
      "${baseurlVehicleRecomend}shimoga-4.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "two-wheeler"
  ),
  VehicleModel(
    id: 9,
    name: "Car Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlVehiclePopular}udupi-3.jpg",
      "${baseurlVehiclePopular}udupi-1.jpg",
      "${baseurlVehiclePopular}udupi-2.jpg",
      "${baseurlVehiclePopular}udupi-4.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "four-wheeler"
  ),
  VehicleModel(
    id: 12,
    name: "Bajaj Bike Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlVehicleRecomend}shravanabelagola-1.jpg",
      "${baseurlVehicleRecomend}shravanabelagola-2.jpeg",
      "${baseurlVehicleRecomend}shravanabelagola-3.jpg",
      "${baseurlVehicleRecomend}shravanabelagola-4.jpeg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "two-wheeler"
  ),
  VehicleModel(
    id: 14,
    name: "Car Rentals",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
    image: [
      "${baseurlVehicleRecomend}coorg-1.jpg",
      "${baseurlVehicleRecomend}coorg-2.jpg",
      "${baseurlVehicleRecomend}coorg-3.jpg",
      "${baseurlVehicleRecomend}coorg-4.jpg",
    ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "four-wheeler"
  ),
];
const description =
    'Travel places offer a wide array of experiences, each with its own unique charm and appeal. From stunning natural landscapes to historic landmarks, there is something for every traveler. Coastal TravelDestinations like tropical beaches invite relaxation with crystal-clear waters, while mountainous regions offer adventurous hiking trails and breathtaking views.';

import 'dart:math';

import 'package:travel_vehicle_planner/constant/baseurl/baseurl.dart';

Random random = Random();

class TravelDestination {
  final int id, price, review;
  final List<String>? image;
  final String name, description, category, location;
  final double rate;

  TravelDestination({
    required this.name,
    required this.price,
    required this.id,
    required this.category,
    required this.description,
    required this.review,
    required this.image,
    required this.rate,
    required this.location,
  });
}

List<TravelDestination> myDestination = [
  TravelDestination(
    id: 2,
    name: "Hampi",
    category: 'popular',
    image: [
      "${baseurlPopular}hampi-1.jpg",
      "${baseurlPopular}hampi-2.jpg",
      "${baseurlPopular}hampi-3.jpg",
      "${baseurlPopular}hampi-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 999,
    description: description,
    rate: 4.9,
  ),
  TravelDestination(
    id: 7,
    price: 5000,
    name: "Mysore Palace",
    image: [
      "${baseurlPopular}mysore-1.jpg",
      "${baseurlPopular}mysore-2.jpg",
      "${baseurlPopular}mysore-3.jpg",
      "${baseurlPopular}mysore-4.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
  ),
  TravelDestination(
    id: 3,
    name: "Chikmangaluru",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlRecomend}chikmangaluru-1.jpg",
      "${baseurlRecomend}chikmangaluru-2.jpg",
      "${baseurlRecomend}chikmangaluru-3.jpg",
      "${baseurlRecomend}chikmangaluru-4.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
  ),
  TravelDestination(
    id: 8,
    name: "Uttara Kannada",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlPopular}uttarakannada-1.jpg",
      "${baseurlPopular}uttarakannada-2.jpg",
      "${baseurlPopular}uttarakannada-3.jpg",
      "${baseurlPopular}uttarakannada-4.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
  ),
  TravelDestination(
    id: 1,
    name: "Shimoga",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlRecomend}shimogga-1.jpg",
      "${baseurlRecomend}shimogga-2.jpg",
      "${baseurlRecomend}shimogga-3.jpg",
      "${baseurlRecomend}shimoga-4.png",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
  ),
  TravelDestination(
    id: 9,
    name: "Udupi",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlPopular}udupi-3.JPG",
      "${baseurlPopular}udupi-1.png",
      "${baseurlPopular}udupi-2.jpg",
      "${baseurlPopular}udupi-4.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
  ),
  TravelDestination(
    id: 12,
    name: "Shravanabelagola",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlRecomend}shravanabelagola-1.jpg",
      "${baseurlRecomend}shravanabelagola-2.jpg",
      "${baseurlRecomend}shravanabelagola-3.jpg",
      "${baseurlRecomend}shravanabelagola-4.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
  ),
  TravelDestination(
    id: 14,
    name: "Coorg",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
    image: [
      "${baseurlRecomend}coorg-4.jpg",
      "${baseurlRecomend}coorg-2.jpg",
      "${baseurlRecomend}coorg-3.jpg",
      "${baseurlRecomend}coorg-4.jpg",
    ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
  ),
];
const description =
    'Travel places offer a wide array of experiences, each with its own unique charm and appeal. From stunning natural landscapes to historic landmarks, there is something for every traveler. Coastal TravelDestinations like tropical beaches invite relaxation with crystal-clear waters, while mountainous regions offer adventurous hiking trails and breathtaking views.';

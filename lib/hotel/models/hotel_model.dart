import 'dart:math';

import 'package:travel_vehicle_planner/constant/baseurl/baseurl.dart';

Random random = Random();

class HotelDestination {
  final int id, price, review;
  final List<String>? image;
  final String name, description, category, location;
  final double rate;

  HotelDestination({
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

List<HotelDestination> hotelDestination = [
  HotelDestination(
    id: 2,
    name: "Heritage Resort",
    category: 'popular',
    image: [
      "${baseurlHotelPopular}hampi-1.jpg",
      "${baseurlHotelPopular}hampi-2.jpg",
      "${baseurlHotelPopular}hampi-3.jpg",
      "${baseurlHotelPopular}hampi-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
  ),
  HotelDestination(
    id: 7,
    price: 5000,
    name: "Aditya Hotel",
    image: [
      "${baseurlHotelPopular}mysore-1.jpg",
      "${baseurlHotelPopular}mysore-2.jpg",
      "${baseurlHotelPopular}mysore-3.jpg",
      "${baseurlHotelPopular}mysore-4.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
  ),
  HotelDestination(
    id: 3,
    name: "Chikkamane Homestay",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlHotelRecomend}chikmangaluru-1.jpg",
      "${baseurlHotelRecomend}chikmangaluru-2.jpg",
      "${baseurlHotelRecomend}chikmangaluru-3.jpg",
      "${baseurlHotelRecomend}chikmangaluru-4.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
  ),
  HotelDestination(
    id: 8,
    name: "Zostel",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlHotelPopular}uttarakannada-1.jpg",
      "${baseurlHotelPopular}uttarakannada-2.jpg",
      "${baseurlHotelPopular}uttarakannada-3.jpg",
      "${baseurlHotelPopular}uttarakannada-4.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
  ),
  HotelDestination(
    id: 1,
    name: "Breeze Resort",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlHotelRecomend}shimogga-1.jpg",
      "${baseurlHotelRecomend}shimogga-2.jpg",
      "${baseurlHotelRecomend}shimogga-3.jpg",
      "${baseurlHotelRecomend}shimoga-4.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
  ),
  HotelDestination(
    id: 9,
    name: "Paradise Lagoon",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlHotelPopular}udupi-3.jpg",
      "${baseurlHotelPopular}udupi-1.jpg",
      "${baseurlHotelPopular}udupi-2.jpg",
      "${baseurlHotelPopular}udupi-4.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
  ),
  HotelDestination(
    id: 12,
    name: "The VANA - Valley Retreat",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlHotelRecomend}shravanabelagola-1.jpg",
      "${baseurlHotelRecomend}shravanabelagola-2.jpg",
      "${baseurlHotelRecomend}shravanabelagola-3.jpg",
      "${baseurlHotelRecomend}shravanabelagola-4.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
  ),
  HotelDestination(
    id: 14,
    name: "Jungle Hill Resort",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
    image: [
      "${baseurlHotelRecomend}coorg-4.jpg",
      "${baseurlHotelRecomend}coorg-2.jpg",
      "${baseurlHotelRecomend}coorg-3.jpg",
      "${baseurlHotelRecomend}coorg-4.jpg",
    ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
  ),
];
const description =
    'Travel places offer a wide array of experiences, each with its own unique charm and appeal. From stunning natural landscapes to historic landmarks, there is something for every traveler. Coastal TravelDestinations like tropical beaches invite relaxation with crystal-clear waters, while mountainous regions offer adventurous hiking trails and breathtaking views.';

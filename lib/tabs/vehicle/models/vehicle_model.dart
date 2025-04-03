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
    type: "two-wheeler-scooty"
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
    type: 'car'
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
    type: "two-wheeler-scooty"
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
    type: "car"
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
    type: "two-wheeler-bike"
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
    type: "four-wheeler-car"
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
    type: "two-wheeler-bike"
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
    type: "car"
  ),






  // two wheeler bikes

    VehicleModel(
    id: 2,
    name: "Bikes",
    category: 'popular',
    image: [
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-1.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-2.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-3.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "two-wheeler-bike"
  ),
    VehicleModel(
    id: 14,
    name: "Bike Rentals",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
    image: [
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-5.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-6.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-7.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-8.jpg",
    ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "two-wheeler-bike"
  ),

   VehicleModel(
    id: 9,
    name: "Bike Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
     "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-9.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-10.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-11.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-12.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "two-wheeler-bike"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Bike Rental",
    image: [
 "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-7.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-1.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-11.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-10.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'two-wheeler-bike'
  ),

    VehicleModel(
    id: 8,
    name: "Bike Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
    "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-4.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-1.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-8.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-7.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "two-wheeler-bike"
  ),

    VehicleModel(
    id: 3,
    name: "Bike Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
     "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-12.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-1.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-8.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-7.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "two-wheeler-bike"
  ),

    VehicleModel(
    id: 1,
    name: "Bike Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
    "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-11.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-1.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-8.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-7.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "two-wheeler-bike"
  ),

    VehicleModel(
    id: 12,
    name: "Bike Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
       "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-3.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-1.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-8.jpg",
      "${baseurlVehicleTwoWheelerBikes}two-wheeler-bike-7.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "two-wheeler-bike"
  ),

  // ----------------
  // two wheeler scooty

  
    VehicleModel(
    id: 2,
    name: "Scooter",
    category: 'popular',
    image: [
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-1.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-2.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-3.png",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "two-wheeler-scooty"
  ),
    VehicleModel(
    id: 14,
    name: "Scooty",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
    image: [
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-5.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-6.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-7.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-8.jpg",
    ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "two-wheeler-scooty"
  ),

   VehicleModel(
    id: 9,
    name: "Scooty Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
     "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-9.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-10.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-11.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-12.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "two-wheeler-scooty"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Scooty Rental",
    image: [
 "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-7.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-1.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-11.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-10.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'two-wheeler-scooty'
  ),

    VehicleModel(
    id: 8,
    name: "Scooty Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
    "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-4.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-1.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-8.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-7.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "two-wheeler-scooty"
  ),

    VehicleModel(
    id: 3,
    name: "Scooty Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
     "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-12.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-1.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-8.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-7.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "two-wheeler-scooty"
  ),

    VehicleModel(
    id: 1,
    name: "Scooty Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
    "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-11.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-1.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-8.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-7.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "two-wheeler-scooty"
  ),

    VehicleModel(
    id: 12,
    name: "Scooty Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
       "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-3.png",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-1.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-8.jpg",
      "${baseurlVehicleTwoWheelerScooty}two-wheeler-scooty-7.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "two-wheeler-scooty"
  ),

  //  electric

  
    VehicleModel(
    id: 2,
    name: "Electric",
    category: 'popular',
    image: [
      "${baseurlVehicleElectric}electric-1.png",
      "${baseurlVehicleElectric}electric-2.jpg",
      "${baseurlVehicleElectric}electric-3.jpg",
      "${baseurlVehicleElectric}electric-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "electric"
  ),
    VehicleModel(
    id: 14,
    name: "Electric",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
      image: [
      "${baseurlVehicleElectric}electric-5.jpg",
      "${baseurlVehicleElectric}electric-1.png",
      "${baseurlVehicleElectric}electric-2.jpg",
      "${baseurlVehicleElectric}electric-3.jpg",
      ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "electric"
  ),

   VehicleModel(
    id: 9,
    name: "Electric Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
    "${baseurlVehicleElectric}electric-4.jpg",
      "${baseurlVehicleElectric}electric-5.jpg",
      "${baseurlVehicleElectric}electric-1.png",
      "${baseurlVehicleElectric}electric-2.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "electric"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Electric Rental",
    image: [
    "${baseurlVehicleElectric}electric-3.jpg",
      "${baseurlVehicleElectric}electric-4.jpg",
      "${baseurlVehicleElectric}electric-5.jpg",
      "${baseurlVehicleElectric}electric-1.png",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'electric'
  ),

    VehicleModel(
    id: 8,
    name: "Electric Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
     "${baseurlVehicleElectric}electric-2.jpg",
      "${baseurlVehicleElectric}electric-3.jpg",
      "${baseurlVehicleElectric}electric-4.jpg",
      "${baseurlVehicleElectric}electric-5.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "electric"
  ),

    VehicleModel(
    id: 3,
    name: "Electric Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlVehicleElectric}electric-4.jpg",
      "${baseurlVehicleElectric}electric-2.jpg",
      "${baseurlVehicleElectric}electric-4.jpg",
      "${baseurlVehicleElectric}electric-5.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "electric"
  ),

    VehicleModel(
    id: 1,
    name: "Electric Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
    "${baseurlVehicleElectric}electric-1.png",
      "${baseurlVehicleElectric}electric-2.jpg",
      "${baseurlVehicleElectric}electric-4.jpg",
      "${baseurlVehicleElectric}electric-5.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "electric"
  ),

    VehicleModel(
    id: 12,
    name: "Electric Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlVehicleElectric}electric-2.jpg",
      "${baseurlVehicleElectric}electric-1.png",
      "${baseurlVehicleElectric}electric-4.jpg",
      "${baseurlVehicleElectric}electric-5.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "electric"
  ),

  //  four wheeler car

  
    VehicleModel(
    id: 2,
    name: "Car",
    category: 'popular',
    image: [
      "${baseurlVehicleCar}car-1.jpg",
      "${baseurlVehicleCar}car-2.jpg",
      "${baseurlVehicleCar}car-3.jpg",
      "${baseurlVehicleCar}car-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "car"
  ),
    VehicleModel(
    id: 14,
    name: "Car",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
      image: [
       "${baseurlVehicleCar}car-5.jpg",
      "${baseurlVehicleCar}car-6.jpg",
      "${baseurlVehicleCar}car-7.jpg",
      "${baseurlVehicleCar}car-8.jpg",
      ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "car"
  ),

   VehicleModel(
    id: 9,
    name: "Car Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlVehicleCar}car-9.jpg",
      "${baseurlVehicleCar}car-10.jpg",
      "${baseurlVehicleCar}car-11.jpg",
      "${baseurlVehicleCar}car-12.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "car"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Car Rental",
    image: [
      "${baseurlVehicleCar}car-2.jpg",
      "${baseurlVehicleCar}car-3.jpg",
      "${baseurlVehicleCar}car-4.jpg",
      "${baseurlVehicleCar}car-5.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'car'
  ),

    VehicleModel(
    id: 8,
    name: "Car Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlVehicleCar}car-6.jpg",
      "${baseurlVehicleCar}car-7.jpg",
      "${baseurlVehicleCar}car-8.jpg",
      "${baseurlVehicleCar}car-9.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "car"
  ),

    VehicleModel(
    id: 3,
    name: "Car Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlVehicleCar}car-10.jpg",
      "${baseurlVehicleCar}car-11.jpg",
      "${baseurlVehicleCar}car-12.jpg",
      "${baseurlVehicleCar}car-13.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "car"
  ),

    VehicleModel(
    id: 1,
    name: "Car Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlVehicleCar}car-14.jpg",
      "${baseurlVehicleCar}car-15.jpg",
      "${baseurlVehicleCar}car-16.jpg",
      "${baseurlVehicleCar}car-1.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "car"
  ),

    VehicleModel(
    id: 12,
    name: "Car Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlVehicleCar}car-13.jpg",
      "${baseurlVehicleCar}car-6.jpg",
      "${baseurlVehicleCar}car-7.jpg",
      "${baseurlVehicleCar}car-8.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "car"
  ),

  // jeep
    
    VehicleModel(
    id: 2,
    name: "Jeep",
    category: 'popular',
    image: [
      "${baseurlVehicleJeep}jeep-1.jpg",
      "${baseurlVehicleJeep}jeep-2.jpg",
      "${baseurlVehicleJeep}jeep-3.jpg",
      "${baseurlVehicleJeep}jeep-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "jeep"
  ),
    VehicleModel(
    id: 14,
    name: "Jeep",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
      image: [
       "${baseurlVehicleJeep}jeep-5.jpg",
      "${baseurlVehicleJeep}jeep-6.jpg",
      "${baseurlVehicleJeep}jeep-7.jpg",
      "${baseurlVehicleJeep}jeep-8.jpg",
      ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "jeep"
  ),

   VehicleModel(
    id: 9,
    name: "Jeep Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlVehicleJeep}jeep-9.jpg",
      "${baseurlVehicleJeep}jeep-10.jpg",
      "${baseurlVehicleJeep}jeep-11.jpg",
      "${baseurlVehicleJeep}jeep-12.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "jeep"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Jeep Rental",
    image: [
      "${baseurlVehicleJeep}jeep-2.jpg",
      "${baseurlVehicleJeep}jeep-3.jpg",
      "${baseurlVehicleJeep}jeep-4.jpg",
      "${baseurlVehicleJeep}jeep-5.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'jeep'
  ),

    VehicleModel(
    id: 8,
    name: "Jeep Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlVehicleJeep}jeep-6.jpg",
      "${baseurlVehicleJeep}jeep-7.jpg",
      "${baseurlVehicleJeep}jeep-8.jpg",
      "${baseurlVehicleJeep}jeep-9.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "jeep"
  ),

    VehicleModel(
    id: 3,
    name: "Jeep Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlVehicleJeep}jeep-10.jpg",
      "${baseurlVehicleJeep}jeep-11.jpg",
      "${baseurlVehicleJeep}jeep-12.jpg",
      "${baseurlVehicleJeep}jeep-10.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "jeep"
  ),

    VehicleModel(
    id: 1,
    name: "Jeep Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlVehicleJeep}jeep-9.jpg",
      "${baseurlVehicleJeep}jeep-8.jpg",
      "${baseurlVehicleJeep}jeep-7.jpg",
      "${baseurlVehicleJeep}jeep-1.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "jeep"
  ),

    VehicleModel(
    id: 12,
    name: "Jeep Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlVehicleJeep}jeep-7.jpg",
      "${baseurlVehicleJeep}jeep-6.jpg",
      "${baseurlVehicleJeep}jeep-7.jpg",
      "${baseurlVehicleJeep}jeep-8.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "jeep"
  ),

// open jeep
  
    VehicleModel(
    id: 2,
    name: "Open Jeep",
    category: 'popular',
    image: [
      "${baseurlVehicleOpenJeep}jeep-1.jpg",
      "${baseurlVehicleOpenJeep}jeep-2.jpg",
      "${baseurlVehicleOpenJeep}jeep-3.jpg",
      "${baseurlVehicleOpenJeep}jeep-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "openjeep"
  ),
    VehicleModel(
    id: 14,
    name: "Open Jeep",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
      image: [
       "${baseurlVehicleOpenJeep}jeep-5.jpg",
      "${baseurlVehicleOpenJeep}jeep-6.jpg",
      "${baseurlVehicleOpenJeep}jeep-7.jpg",
      "${baseurlVehicleOpenJeep}jeep-8.jpeg",
      ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "openjeep"
  ),

   VehicleModel(
    id: 9,
    name: "Open Jeep Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlVehicleOpenJeep}jeep-9.jpg",
      "${baseurlVehicleOpenJeep}jeep-10.jpg",
      "${baseurlVehicleOpenJeep}jeep-11.png",
      "${baseurlVehicleOpenJeep}jeep-12.png",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "openjeep"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Open Jeep Rental",
    image: [
      "${baseurlVehicleOpenJeep}jeep-2.jpg",
      "${baseurlVehicleOpenJeep}jeep-3.jpg",
      "${baseurlVehicleOpenJeep}jeep-4.jpg",
      "${baseurlVehicleOpenJeep}jeep-5.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'openjeep'
  ),

    VehicleModel(
    id: 8,
    name: "Open Jeep Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlVehicleOpenJeep}jeep-6.jpg",
      "${baseurlVehicleOpenJeep}jeep-7.jpg",
      "${baseurlVehicleOpenJeep}jeep-8.jpeg",
      "${baseurlVehicleOpenJeep}jeep-9.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "openjeep"
  ),

    VehicleModel(
    id: 3,
    name: "Open Jeep Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlVehicleOpenJeep}jeep-10.jpg",
      "${baseurlVehicleOpenJeep}jeep-11.png",
      "${baseurlVehicleOpenJeep}jeep-12.png",
      "${baseurlVehicleOpenJeep}jeep-1.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "openjeep"
  ),

    VehicleModel(
    id: 1,
    name: "Open Jeep Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlVehicleOpenJeep}jeep-11.png",
      "${baseurlVehicleOpenJeep}jeep-3.jpg",
      "${baseurlVehicleOpenJeep}jeep-4.jpg",
      "${baseurlVehicleOpenJeep}jeep-1.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "openjeep"
  ),

    VehicleModel(
    id: 12,
    name: "Open Jeep Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlVehicleOpenJeep}jeep-9.jpg",
      "${baseurlVehicleOpenJeep}jeep-10.jpg",
      "${baseurlVehicleOpenJeep}jeep-7.jpg",
      "${baseurlVehicleOpenJeep}jeep-8.jpeg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "openjeep"
  ),

  // cycle
    
    VehicleModel(
    id: 2,
    name: "Cycle",
    category: 'popular',
    image: [
      "${baseurlVehicleCycle}cycle-1.jpg",
      "${baseurlVehicleCycle}cycle-2.jpg",
      "${baseurlVehicleCycle}cycle-3.jpg",
      "${baseurlVehicleCycle}cycle-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "mancycle"
  ),
    VehicleModel(
    id: 14,
    name: "Cycle",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
      image: [
       "${baseurlVehicleCycle}cycle-5.jpg",
      "${baseurlVehicleCycle}cycle-6.jpg",
      "${baseurlVehicleCycle}cycle-7.png",
      "${baseurlVehicleCycle}cycle-8.jpg",
      ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "mancycle"
  ),

   VehicleModel(
    id: 9,
    name: "Cycle Rentals",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlVehicleCycle}cycle-9.jpg",
      "${baseurlVehicleCycle}cycle-10.jpg",
      "${baseurlVehicleCycle}cycle-11.jpg",
      "${baseurlVehicleCycle}cycle-12.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "mancycle"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Cycle Rental",
    image: [
      "${baseurlVehicleCycle}cycle-2.jpg",
      "${baseurlVehicleCycle}cycle-3.jpg",
      "${baseurlVehicleCycle}cycle-4.jpg",
      "${baseurlVehicleCycle}cycle-5.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'mancycle'
  ),

    VehicleModel(
    id: 8,
    name: "Cycle Rentals",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlVehicleCycle}cycle-6.jpg",
      "${baseurlVehicleCycle}cycle-7.png",
      "${baseurlVehicleCycle}cycle-8.jpg",
      "${baseurlVehicleCycle}cycle-9.jpg",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "mancycle"
  ),

    VehicleModel(
    id: 3,
    name: "Cycle Rentals",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlVehicleCycle}cycle-10.jpg",
      "${baseurlVehicleCycle}cycle-11.jpg",
      "${baseurlVehicleCycle}cycle-12.jpg",
      "${baseurlVehicleCycle}cycle-1.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "mancycle"
  ),

    VehicleModel(
    id: 1,
    name: "Cycle Rentals",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlVehicleCycle}cycle-11.jpg",
      "${baseurlVehicleCycle}cycle-3.jpg",
      "${baseurlVehicleCycle}cycle-4.jpg",
      "${baseurlVehicleCycle}cycle-1.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "mancycle"
  ),

    VehicleModel(
    id: 12,
    name: "Cycle Rentals",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlVehicleCycle}cycle-9.jpg",
      "${baseurlVehicleCycle}cycle-10.jpg",
      "${baseurlVehicleCycle}cycle-11.jpg",
      "${baseurlVehicleCycle}cycle-12.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "mancycle"
  ),

  // lady bird
  
    VehicleModel(
    id: 2,
    name: "Ladybird Cycle",
    category: 'popular',
    image: [
      "${baseurlVehicleWomenCycle}cycle-1.jpg",
      "${baseurlVehicleWomenCycle}cycle-2.jpg",
      "${baseurlVehicleWomenCycle}cycle-3.jpg",
      "${baseurlVehicleWomenCycle}cycle-4.jpg",
    ],
    location: "Hampi,Karnataka",
    review: random.nextInt(300) + 25,
    price: 1999,
    description: description,
    rate: 5.0,
    type: "ladybird"
  ),
    VehicleModel(
    id: 14,
    name: "Ladybird Cycle",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
      image: [
       "${baseurlVehicleWomenCycle}cycle-5.jpg",
      "${baseurlVehicleWomenCycle}cycle-6.jpg",
      "${baseurlVehicleWomenCycle}cycle-7.png",
      "${baseurlVehicleWomenCycle}cycle-8.jpg",
      ],
    location: "Coorg, Karnataka",
    description: description,
    rate: 4.7,
    type: "ladybird"
  ),

   VehicleModel(
    id: 9,
    name: "Ladybird Cycle",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "${baseurlVehicleWomenCycle}cycle-9.png",
      "${baseurlVehicleWomenCycle}cycle-10.jpg",
      "${baseurlVehicleWomenCycle}cycle-11.png",
      "${baseurlVehicleWomenCycle}cycle-12.jpg",
    ],
    location: "Udupi, Karnataka",
    description: description,
    rate: 4.7,
    type: "ladybird"
  ),

    VehicleModel(
    id: 7,
    price: 5000,
    name: "Ladybird Cycle",
    image: [
      "${baseurlVehicleWomenCycle}cycle-2.jpg",
      "${baseurlVehicleWomenCycle}cycle-3.jpg",
      "${baseurlVehicleWomenCycle}cycle-4.jpg",
      "${baseurlVehicleWomenCycle}cycle-5.jpg",
      ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Mysore, Karnataka",
    description: description,
    rate: 5.0,
    type: 'ladybird'
  ),

    VehicleModel(
    id: 8,
    name: "Ladybird Cycle",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "${baseurlVehicleWomenCycle}cycle-6.jpg",
      "${baseurlVehicleWomenCycle}cycle-7.png",
      "${baseurlVehicleWomenCycle}cycle-8.jpg",
      "${baseurlVehicleWomenCycle}cycle-9.png",
    ],
    location: "Uttara Kannada, Karnataka",
    description: description,
    rate: 4.5,
    type: "ladybird"
  ),

    VehicleModel(
    id: 3,
    name: "Ladybird Cycle",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "${baseurlVehicleWomenCycle}cycle-10.jpg",
      "${baseurlVehicleWomenCycle}cycle-11.png",
      "${baseurlVehicleWomenCycle}cycle-12.jpg",
      "${baseurlVehicleWomenCycle}cycle-1.jpg",
    ],
    location: "Chikmangaluru, Karnataka",
    description: description,
    rate: 4.9,
    type: "ladybird"
  ),

    VehicleModel(
    id: 1,
    name: "Ladybird Cycle",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "${baseurlVehicleWomenCycle}cycle-11.png",
      "${baseurlVehicleWomenCycle}cycle-3.jpg",
      "${baseurlVehicleWomenCycle}cycle-4.jpg",
      "${baseurlVehicleWomenCycle}cycle-1.jpg",
    ],
    location: "Shimoga, Karnataka",
    description: description,
    rate: 4.6,
    type: "ladybird"
  ),

    VehicleModel(
    id: 12,
    name: "Ladybird Cycle",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "${baseurlVehicleWomenCycle}cycle-9.png",
      "${baseurlVehicleWomenCycle}cycle-10.jpg",
      "${baseurlVehicleWomenCycle}cycle-11.png",
      "${baseurlVehicleWomenCycle}cycle-12.jpg",
      ],
    location: "Shravanabelagola, Karnataka",
    description: description,
    rate: 4.8,
    type: "ladybird"
  ),










];
const description =
    'Travel places offer a wide array of experiences, each with its own unique charm and appeal. From stunning natural landscapes to historic landmarks, there is something for every traveler. Coastal TravelDestinations like tropical beaches invite relaxation with crystal-clear waters, while mountainous regions offer adventurous hiking trails and breathtaking views.';

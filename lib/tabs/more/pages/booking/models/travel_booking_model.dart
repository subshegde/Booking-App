import 'package:travel_vehicle_planner/db/database_helper.dart';

class TravelBookingModel {
  int? id;
  String name;
  String gender;
  String address;
  String phone;
  String email;
  String date;
  int numberOfPerson;
  int isPaymentDone;
  double totalPrice;
  int travelId; // Reference to travel ID
  int userId; // Reference to user ID

  TravelBookingModel({
    required this.name,
    required this.gender,
    required this.address,
    required this.phone,
    required this.email,
    required this.numberOfPerson,
    required this.travelId,
    required this.userId,
    required this.isPaymentDone,
    required this.totalPrice,
    required this.date,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'address': address,
      'phone': phone,
      'email': email,
      'numberOfPerson': numberOfPerson,
      'travelId': travelId,
      'userId': userId,
      'isPaymentDone': isPaymentDone,
      'totalPrice': totalPrice,
      'date': date,
    };
  }
}

class TravelBookingManager {
  // Add Travel Booking
  static Future<bool> addTravelBooking(TravelBookingModel booking) async {
    try {
      final result = await DatabaseHelper().insertTravelBooking(booking.toMap());
      return result > 0; // Return true if insertion was successful
    } catch (e) {
      print('Error adding booking: $e');
      return false; // Return false if an error occurs
    }
  }

  // Get All Travel Bookings
// Get All Travel Bookings for a Specific User
  static Future<List<TravelBookingModel>> getAllTravelBookings(int userId) async {
    final bookingsData = await DatabaseHelper().getAllTravelBookings(userId);
    return bookingsData.map((data) {
      return TravelBookingModel(
        id: data['id'],
        name: data['name'],
        date: data['date'],
        gender: data['gender'],
        address: data['address'],
        phone: data['phone'],
        email: data['email'],
        numberOfPerson: data['numberOfPerson'],
        travelId: data['travelId'],
        userId: data['userId'],
        isPaymentDone: data['isPaymentDone'],
        totalPrice: data['totalPrice'],
      );
    }).toList();
  }

  // Remove Travel Booking
  Future<void> removeTravelBooking(int id) async {
    await DatabaseHelper().removeTravelBookingById(id);
  }
}

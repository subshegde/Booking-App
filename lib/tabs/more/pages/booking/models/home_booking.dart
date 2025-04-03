import 'package:travel_vehicle_planner/db/database_helper.dart';

class HomeBookingModel {
  String name;
  String gender;
  String address;
  String phone;
  String email;
  String date;
  int numberOfPerson;
  int isPaymentDone;
  double totalPrice;
  int hotelId; // Reference to hotel ID
  int userId; // Reference to user ID

  HomeBookingModel({
    required this.name,
    required this.gender,
    required this.address,
    required this.phone,
    required this.email,
    required this.numberOfPerson,
    required this.hotelId,
    required this.userId,
    required this.isPaymentDone,
    required this.totalPrice,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'address': address,
      'phone': phone,
      'email': email,
      'numberOfPerson': numberOfPerson,
      'hotelId': hotelId,
      'userId': userId,
      'isPaymentDone': isPaymentDone,
      'totalPrice': totalPrice,
      'date': date,
    };
  }
}

class BookingManager {
  // Add Booking
  static Future<bool> addBooking(HomeBookingModel booking) async {
    try {
      final result = await DatabaseHelper().insertBooking(booking.toMap());
      return result > 0; // Return true if insertion was successful
    } catch (e) {
      print('Error adding booking: $e');
      return false; // Return false if an error occurs
    }
  }

  // Get All Bookings
// Get All Bookings for a Specific User
  static Future<List<HomeBookingModel>> getAllBookings(int userId) async {
    final bookingsData = await DatabaseHelper().getAllBookings(userId);
    return bookingsData.map((data) {
      return HomeBookingModel(
        name: data['name'],
        date: data['date'],
        gender: data['gender'],
        address: data['address'],
        phone: data['phone'],
        email: data['email'],
        numberOfPerson: data['numberOfPerson'],
        hotelId: data['hotelId'],
        userId: data['userId'],
        isPaymentDone: data['isPaymentDone'],
        totalPrice: data['totalPrice'],
      );
    }).toList();
  }

  // Remove Booking
  Future<void> removeBooking(int id) async {
    await DatabaseHelper().removeBookingById(id);
  }
}

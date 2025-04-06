import 'package:travel_vehicle_planner/db/database_helper.dart';

class VehicleBookingModel {
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
  int vehicleId; // Reference to Vehicle ID
  int userId; // Reference to user ID

  VehicleBookingModel({
    required this.name,
    required this.gender,
    required this.address,
    required this.phone,
    required this.email,
    required this.numberOfPerson,
    required this.vehicleId,
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
      'vehicleId': vehicleId,
      'userId': userId,
      'isPaymentDone': isPaymentDone,
      'totalPrice': totalPrice,
      'date': date,
    };
  }
}

class VehicleBookingManager {
  // Add Booking
  static Future<bool> addVehicleBooking(VehicleBookingModel booking) async {
    try {
      final result = await DatabaseHelper().insertVehicleBooking(booking.toMap());
      return result > 0; // Return true if insertion was successful
    } catch (e) {
      print('Error adding booking: $e');
      return false; // Return false if an error occurs
    }
  }

  // Get All Bookings
// Get All Bookings for a Specific User
  static Future<List<VehicleBookingModel>> getAllVehicleBookings(int userId) async {
    final bookingsData = await DatabaseHelper().getAllVehicleBookings(userId);
    return bookingsData.map((data) {
      return VehicleBookingModel(
        id: data['id'],
        name: data['name'],
        date: data['date'],
        gender: data['gender'],
        address: data['address'],
        phone: data['phone'],
        email: data['email'],
        numberOfPerson: data['numberOfPerson'],
        vehicleId: data['vehicleId'],
        userId: data['userId'],
        isPaymentDone: data['isPaymentDone'],
        totalPrice: data['totalPrice'],
      );
    }).toList();
  }

  // Remove Booking
  Future<void> removeVehicleBooking(int id) async {
    await DatabaseHelper().removeVehicleBookingById(id);
  }
}

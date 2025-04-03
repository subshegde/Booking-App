import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';
import 'package:travel_vehicle_planner/tabs/more/pages/booking/models/home_booking.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Bookings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Hotel'),
              Tab(text: 'Travel'),
              Tab(text: 'Vehicle'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HotelBookingTab(),
            TravelBookingTab(),
            VehicleBookingTab(),
          ],
        ),
      ),
    );
  }
}

class HotelBookingTab extends StatefulWidget {
  const HotelBookingTab({Key? key}) : super(key: key);

  @override
  _HotelBookingTabState createState() => _HotelBookingTabState();
}

class _HotelBookingTabState extends State<HotelBookingTab> {
  List<HomeBookingModel> homeBooking = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');
    homeBooking = await BookingManager.getAllBookings(userId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          homeBooking.isEmpty
              ? const Center(
                  child: Text(
                    'No Booking Found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const Text(
                  'Hotel Booking',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: homeBooking.length,
              itemBuilder: (context, index) {
                final booking = homeBooking[index];
                return _buildBookingCard(booking);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(HomeBookingModel booking) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  booking.date ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Booking Details
            _buildDetailRow(Icons.person, 'Gender: ${booking.gender ?? 'N/A'}'),
            _buildDetailRow(
                Icons.location_on, 'Address: ${booking.address ?? 'N/A'}'),
            _buildDetailRow(Icons.phone, 'Phone: ${booking.phone ?? 'N/A'}'),
            _buildDetailRow(Icons.email, 'Email: ${booking.email ?? 'N/A'}'),
            _buildDetailRow(
                Icons.group, 'Guests: ${booking.numberOfPerson ?? 0}'),
            _buildDetailRow(
              Icons.payment,
              'Payment Status: ${booking.isPaymentDone == 1 ? '✅ Paid' : '❌ Unpaid'}',
            ),
            _buildDetailRow(Icons.monetization_on,
                'Total Price: \$${booking.totalPrice?.toStringAsFixed(2) ?? '0.00'}'),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                },
                icon: const Icon(
                  Icons.info_outline,
                  color: AppColors.white,
                ),
                label: const Text(
                  'Pay',
                  style: TextStyle(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper Function for Details Row
  Widget _buildDetailRow(IconData icon, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TravelBookingTab extends StatelessWidget {
  const TravelBookingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Travel Booking',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 10),
          const Text('Book your travel with ease and comfort.',
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          _buildBookingCard(
              'Flight to NYC', 'Direct flight with premium services'),
          _buildBookingCard('Train to Paris', 'Scenic route with great views'),
        ],
      ),
    );
  }

  Widget _buildBookingCard(String title, String description) {
    return Card(
      color: Colors.grey[100],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        subtitle: Text(description, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.black),
      ),
    );
  }
}

class VehicleBookingTab extends StatelessWidget {
  const VehicleBookingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Vehicle Booking',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 10),
          const Text('Select the perfect vehicle for your journey.',
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          _buildBookingCard(
              'SUV Rental', 'Spacious & perfect for family trips'),
          _buildBookingCard(
              'Luxury Sedan', 'Comfort and style for business trips'),
        ],
      ),
    );
  }

  Widget _buildBookingCard(String title, String description) {
    return Card(
      color: Colors.grey[100],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        subtitle: Text(description, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.black),
      ),
    );
  }
}

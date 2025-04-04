import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/common/helpers/confirmations/confirmation.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';
import 'package:travel_vehicle_planner/tabs/hotel/models/hotel_model.dart';
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
              : const SizedBox(height: 20),
          const Text(
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
                HotelDestination hotel = hotelDestination
                    .map((e) => e.id == booking.hotelId ? e : null)
                    .firstWhere((e) => e != null) as HotelDestination;
                HomeBookingModel bokkingModel = HomeBookingModel(
                  address: booking.address,
                  name: booking.name,
                  gender: booking.gender,
                  phone: booking.phone,
                  email: booking.email,
                  numberOfPerson: booking.numberOfPerson,
                  hotelId: booking.hotelId,
                  userId: booking.userId,
                  isPaymentDone: booking.isPaymentDone,
                  totalPrice: booking.totalPrice,
                  date: booking.date,
                );
                return BookingCard(
                  booking: bokkingModel,
                  hotelName: hotel.name,
                  location: hotel.location,
                  rating: hotel.rate,
                  url: hotel.image![0],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final HomeBookingModel booking;
  final String hotelName;
  final String url;
  final String location;
  final double? rating;

  const BookingCard({
    Key? key,
    required this.booking,
    required this.url,
    required this.location,
    required this.hotelName,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hotel Image with Overlay
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      hotelName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          location,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          rating?.toStringAsFixed(1) ?? '4.5',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Information:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text('This booking is made by ${booking.name ?? 'N/A'}.',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 4),
                Text('Email: ${booking.email ?? 'N/A'}.',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 4),
                Text('Phone: ${booking.phone ?? 'N/A'}.',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 4),
                Text(
                    'This booking is for ${booking.numberOfPerson ?? 0} guest(s).',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 12),
                Text(
                  '₹ ${booking.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: booking.isPaymentDone == 1
                            ? null
                            : () {
                                // Add payment functionality here
                              },
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: Text(
                          booking.isPaymentDone == 1
                              ? 'Already Paid'
                              : 'Pay Now',
                          style: const TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: booking.isPaymentDone == 1
                              ? Colors.grey
                              : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    if (booking.isPaymentDone == 0) const SizedBox(height: 10),
                    if (booking.isPaymentDone == 0)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showCustomConfirmation(
                              backgroundColor: AppColors.errorColor,
                              context: context,
                              message: 'Are you sure you want to cancel?',
                              title: 'Cancel Confirmation',
                              onNo: () {},
                              onYes: () {},
                            );
                          },
                          icon: const Icon(Icons.cancel, color: Colors.white),
                          label: const Text(
                            'Cancel Booking',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
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

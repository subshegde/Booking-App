import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/common/helpers/confirmations/confirmation.dart';
import 'package:travel_vehicle_planner/common/helpers/snackbar/snackbar.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';
import 'package:travel_vehicle_planner/db/database_helper.dart';
import 'package:travel_vehicle_planner/tabs/hotel/models/hotel_model.dart';
import 'package:travel_vehicle_planner/tabs/more/pages/booking/models/hotel_booking_model.dart';
import 'package:travel_vehicle_planner/tabs/more/pages/booking/models/travel_booking_model.dart';
import 'package:travel_vehicle_planner/tabs/more/pages/booking/models/vehicle_booking_model.dart';
import 'package:travel_vehicle_planner/tabs/tp/models/travel_model.dart';
import 'package:travel_vehicle_planner/tabs/vehicle/models/vehicle_model.dart';

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
  final DatabaseHelper _dbHelper = DatabaseHelper();

  double amount = 0.0;

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getData();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  int bookingId = 0;
  int hotelId = 0;
  int userId = 0;
  int isPaymentDone = 0;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    CustomSnackBar.showPaymentSuccessSnackBar(
        context, '🎉 Payment Successful!', AppColors.green);
    _dbHelper.markPaymentAsDoneForHotelBooking(
        isPaymentDone: isPaymentDone,
        userId: userId,
        hotelId: hotelId,
        bookingId: bookingId);
    getData();
    setState(() {});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CustomSnackBar.showPaymentSuccessSnackBar(
        context, 'Exited!', AppColors.errorColor);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void payNow(
    dynamic totalAmount,
    String name,
    String description,
    String userPhone,
    String userEmail,
  ) {
    var options = {
      'key': 'rzp_test_yRylqYw9CuyFg7',
      'amount': totalAmount * 100,
      'name': name,
      'description': '$description booking',
      'timeout': 120,
      // add users contact & email
      'prefill': {'contact': userPhone, 'email': userEmail}
    };
    _razorpay.open(options);
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
              :
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
                  id: booking.id,
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
                  onTapPay: (booking, hotelname) {
                    amount = booking.totalPrice!;
                    String personName = booking.name!;
                    payNow(amount, personName, hotelname,
                    booking.phone.toString(), booking.email);
                    bookingId = booking.id!;
                    hotelId = booking.hotelId!;
                    userId = booking.userId!;
                    isPaymentDone = 1;
                    setState(() {});
                  },
                  onCancelBooking: () {
                    showCustomConfirmation(
                      backgroundColor: AppColors.errorColor,
                      context: context,
                      message: 'Are you sure you want to cancel?',
                      title: 'Cancel Confirmation',
                      onNo: () {},
                      onYes: () {
                        _dbHelper.removeHotelBookingById(booking.id!);
                        CustomSnackBar.showPaymentSuccessSnackBar(context, '${hotel.name} booking has been canceled successfully!', AppColors.green);
                        getData();
                      },
                    );
                  },
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
  final Function(HomeBookingModel booking, String hotelname)? onTapPay;
  final Function() onCancelBooking;

  const BookingCard({
    Key? key,
    required this.booking,
    required this.url,
    required this.location,
    required this.hotelName,
    required this.rating,
    required this.onTapPay,
    required this.onCancelBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                        const Icon(Icons.location_on, color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          location,
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
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

          // Booking Information Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1.2),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.person, 'Name', booking.name),
                _buildInfoRow(Icons.email, 'Email', booking.email),
                _buildInfoRow(Icons.phone, 'Phone', booking.phone),
                _buildInfoRow(Icons.group, 'Guests', booking.numberOfPerson.toString()),
                _buildInfoRow(Icons.calendar_today, 'Date', booking.date),
                const SizedBox(height: 12),

                // Payment Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${booking.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (booking.isPaymentDone == 1)
                      Image.asset(
                        'assets/global/paid.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (booking.isPaymentDone != 1)
                      ElevatedButton.icon(
                        onPressed: () {
                          if (onTapPay != null) {
                            onTapPay!(booking, hotelName);
                          }
                        },
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    if (booking.isPaymentDone == 0)
                      ElevatedButton.icon(
                        onPressed: onCancelBooking,
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        label: const Text('Cancel', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------- Travel Booking Tab --------------
class TravelBookingTab extends StatefulWidget {
  const TravelBookingTab({Key? key}) : super(key: key);

  @override
  _TravelBookingTabState createState() => _TravelBookingTabState();
}

class _TravelBookingTabState extends State<TravelBookingTab> {
  List<TravelBookingModel> travelBooking = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  double amount = 0.0;

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getData();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  int bookingId = 0;
  int travelId = 0;
  int userId = 0;
  int isPaymentDone = 0;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    CustomSnackBar.showPaymentSuccessSnackBar(
        context, '🎉 Payment Successful!', AppColors.green);
    _dbHelper.markPaymentAsDoneForTravelBooking(
        isPaymentDone: isPaymentDone,
        userId: userId,
        travelId: travelId,
        bookingId: bookingId);
    getData();
    setState(() {});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CustomSnackBar.showPaymentSuccessSnackBar(
        context, 'Exited!', AppColors.errorColor);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void payNow(
    dynamic totalAmount,
    String name,
    String description,
    String userPhone,
    String userEmail,
  ) {
    var options = {
      'key': 'rzp_test_yRylqYw9CuyFg7',
      'amount': totalAmount * 100,
      'name': name,
      'description': '$description booking',
      'timeout': 120,
      // add users contact & email
      'prefill': {'contact': userPhone, 'email': userEmail}
    };
    _razorpay.open(options);
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');
    travelBooking = await TravelBookingManager.getAllTravelBookings(userId!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          travelBooking.isEmpty
              ? const Center(
                  child: Text(
                    'No Travel Booking Found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              :
          const Text(
            'Travel Booking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: travelBooking.length,
              itemBuilder: (context, index) {
                final tbooking = travelBooking[index];
                TravelDestination travel = myDestination
                    .map((e) => e.id == tbooking.travelId ? e : null)
                    .firstWhere((e) => e != null) as TravelDestination;
                TravelBookingModel bookingModel = TravelBookingModel(
                  id: tbooking.id,
                  address: tbooking.address,
                  name: tbooking.name,
                  gender: tbooking.gender,
                  phone: tbooking.phone,
                  email: tbooking.email,
                  numberOfPerson: tbooking.numberOfPerson,
                  travelId: tbooking.travelId,
                  userId: tbooking.userId,
                  isPaymentDone: tbooking.isPaymentDone,
                  totalPrice: tbooking.totalPrice,
                  date: tbooking.date,
                );
                return TravelBookingCard(
                  booking: bookingModel,
                  hotelName: travel.name,
                  location: travel.location,
                  rating: travel.rate,
                  url: travel.image![0],

                  onTapPay: (bookingOnTap, hotelname) {
                    amount = bookingOnTap.totalPrice!;
                    String personName = bookingOnTap.name!;
                    payNow(amount, personName, hotelname,
                    bookingOnTap.phone.toString(), bookingOnTap.email);
                    bookingId = bookingOnTap.id!;
                    travelId = bookingOnTap.travelId!;
                    userId = bookingOnTap.userId!;
                    isPaymentDone = 1;
                    setState(() {});
                  },
                  onCancelBooking: () {
                    showCustomConfirmation(
                      backgroundColor: AppColors.errorColor,
                      context: context,
                      message: 'Are you sure you want to cancel?',
                      title: 'Cancel Confirmation',
                      onNo: () {},
                      onYes: () {
                        _dbHelper.removeTravelBookingById(tbooking.id!);
                        CustomSnackBar.showPaymentSuccessSnackBar(context, '${travel.name} booking has been canceled successfully!', AppColors.green);
                        getData();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class TravelBookingCard extends StatelessWidget {
  final TravelBookingModel booking;
  final String hotelName;
  final String url;
  final String location;
  final double? rating;
  final Function(TravelBookingModel booking, String hotelname)? onTapPay;
  final Function() onCancelBooking;

  const TravelBookingCard({
    Key? key,
    required this.booking,
    required this.url,
    required this.location,
    required this.hotelName,
    required this.rating,
    required this.onTapPay,
    required this.onCancelBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                        const Icon(Icons.location_on, color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          location,
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
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

          // Booking Information Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1.2),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.person, 'Name', booking.name),
                _buildInfoRow(Icons.email, 'Email', booking.email),
                _buildInfoRow(Icons.phone, 'Phone', booking.phone),
                _buildInfoRow(Icons.group, 'Guests', booking.numberOfPerson.toString()),
                _buildInfoRow(Icons.calendar_today, 'Date', booking.date),
                const SizedBox(height: 12),

                // Payment Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${booking.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (booking.isPaymentDone == 1)
                      Image.asset(
                        'assets/global/paid.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (booking.isPaymentDone != 1)
                      ElevatedButton.icon(
                        onPressed: () {
                          if (onTapPay != null) {
                            onTapPay!(booking, hotelName);
                          }
                        },
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    if (booking.isPaymentDone == 0)
                      ElevatedButton.icon(
                        onPressed: onCancelBooking,
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        label: const Text('Cancel', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}


// ----------- Travel Booking Tab --------------
class VehicleBookingTab extends StatefulWidget {
  const VehicleBookingTab({Key? key}) : super(key: key);

  @override
  _VehicleBookingTabState createState() => _VehicleBookingTabState();
}

class _VehicleBookingTabState extends State<VehicleBookingTab> {
  List<VehicleBookingModel> vehicleBooking = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  double amount = 0.0;

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getData();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  int bookingId = 0;
  int vehiclelId = 0;
  int userId = 0;
  int isPaymentDone = 0;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    CustomSnackBar.showPaymentSuccessSnackBar(
        context, '🎉 Payment Successful!', AppColors.green);
    _dbHelper.markPaymentAsDoneForVehicleBooking(
        isPaymentDone: isPaymentDone,
        userId: userId,
        vehicleId: vehiclelId,
        bookingId: bookingId);
    getData();
    setState(() {});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CustomSnackBar.showPaymentSuccessSnackBar(
        context, 'Exited!', AppColors.errorColor);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void payNow(
    dynamic totalAmount,
    String name,
    String description,
    String userPhone,
    String userEmail,
  ) {
    var options = {
      'key': 'rzp_test_yRylqYw9CuyFg7',
      'amount': totalAmount * 100,
      'name': name,
      'description': '$description booking',
      'timeout': 120,
      // add users contact & email
      'prefill': {'contact': userPhone, 'email': userEmail}
    };
    _razorpay.open(options);
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');
    vehicleBooking = await VehicleBookingManager.getAllVehicleBookings(userId!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vehicleBooking.isEmpty
              ? const Center(
                  child: Text(
                    'No Vehicle Booking Found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              :
          const Text(
            'Vehicle Booking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: vehicleBooking.length,
              itemBuilder: (context, index) {
                final vbooking = vehicleBooking[index];
                VehicleModel vehicle = vehiclesList
                    .map((e) => e.id == vbooking.vehicleId ? e : null)
                    .firstWhere((e) => e != null) as VehicleModel;
                VehicleBookingModel bookingModel = VehicleBookingModel(
                  id: vbooking.id,
                  address: vbooking.address,
                  name: vbooking.name,
                  gender: vbooking.gender,
                  phone: vbooking.phone,
                  email: vbooking.email,
                  numberOfPerson: vbooking.numberOfPerson,
                  vehicleId: vbooking.vehicleId,
                  userId: vbooking.userId,
                  isPaymentDone: vbooking.isPaymentDone,
                  totalPrice: vbooking.totalPrice,
                  date: vbooking.date,
                );
                return VehicleBookingCard(
                  booking: bookingModel,
                  hotelName: vehicle.name,
                  location: vehicle.location,
                  rating: vehicle.rate,
                  url: vehicle.image![0],

                  onTapPay: (bookingOnTap, hotelname) {
                    amount = bookingOnTap.totalPrice!;
                    String personName = bookingOnTap.name!;
                    payNow(amount, personName, hotelname,
                    bookingOnTap.phone.toString(), bookingOnTap.email);
                    bookingId = bookingOnTap.id!;
                    vehiclelId = bookingOnTap.vehicleId!;
                    userId = bookingOnTap.userId!;
                    isPaymentDone = 1;
                    setState(() {});
                  },
                  onCancelBooking: () {
                    showCustomConfirmation(
                      backgroundColor: AppColors.errorColor,
                      context: context,
                      message: 'Are you sure you want to cancel?',
                      title: 'Cancel Confirmation',
                      onNo: () {},
                      onYes: () {
                        _dbHelper.removeVehicleBookingById(vbooking.id!);
                        CustomSnackBar.showPaymentSuccessSnackBar(context, '${vehicle.name} booking has been canceled successfully!', AppColors.green);
                        getData();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class VehicleBookingCard extends StatelessWidget {
  final VehicleBookingModel booking;
  final String hotelName;
  final String url;
  final String location;
  final double? rating;
  final Function(VehicleBookingModel booking, String hotelname)? onTapPay;
  final Function() onCancelBooking;

  const VehicleBookingCard({
    Key? key,
    required this.booking,
    required this.url,
    required this.location,
    required this.hotelName,
    required this.rating,
    required this.onTapPay,
    required this.onCancelBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                        const Icon(Icons.location_on, color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          location,
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
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

          // Booking Information Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1.2),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.person, 'Name', booking.name),
                _buildInfoRow(Icons.email, 'Email', booking.email),
                _buildInfoRow(Icons.phone, 'Phone', booking.phone),
                _buildInfoRow(Icons.group, 'Guests', booking.numberOfPerson.toString()),
                _buildInfoRow(Icons.calendar_today, 'Date', booking.date),
                const SizedBox(height: 12),

                // Payment Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${booking.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (booking.isPaymentDone == 1)
                      Image.asset(
                        'assets/global/paid.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (booking.isPaymentDone != 1)
                      ElevatedButton.icon(
                        onPressed: () {
                          if (onTapPay != null) {
                            onTapPay!(booking, hotelName);
                          }
                        },
                        icon: const Icon(Icons.payment, color: Colors.white),
                        label: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    if (booking.isPaymentDone == 0)
                      ElevatedButton.icon(
                        onPressed: onCancelBooking,
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        label: const Text('Cancel', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(140, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
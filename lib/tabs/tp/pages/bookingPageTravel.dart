import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';
import 'package:travel_vehicle_planner/tabs/more/pages/booking/models/travel_booking_model.dart';
import 'package:travel_vehicle_planner/tabs/tp/models/travel_model.dart';

class TravelBookingPage extends StatefulWidget {
  final TravelDestination travel;
  const TravelBookingPage({Key? key, required this.travel}) : super(key: key);

  @override
  _TravelBookingPageState createState() => _TravelBookingPageState();
}

class _TravelBookingPageState extends State<TravelBookingPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', phone = '', address = '';
  String? gender;
  int numberOfPerson = 1;
  DateTime? selectedDate;

  void _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 5),
      lastDate: DateTime(currentDate.year + 5),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

 void _bookTravel() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.black),
      );
    },
  );

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');

    int price = widget.travel.price;
    double totalPrice = price.toDouble() * numberOfPerson;

    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final String formattedDate = selectedDate != null
        ? dateFormat.format(selectedDate!)
        : DateFormat('dd-MM-yyyy').format(DateTime.now());

    final booking = TravelBookingModel(
      name: name,
      gender: gender ?? '',
      address: address,
      phone: phone,
      email: email,
      numberOfPerson: numberOfPerson,
      travelId: widget.travel.id,
      userId: userId!,
      isPaymentDone: 0,
      totalPrice: totalPrice,
      date: formattedDate,
    );

    bool isBookingSuccessful = await TravelBookingManager.addTravelBooking(booking);

    Navigator.pop(context);
    _showBookingResult(isBookingSuccessful);

    // Reset form fields after booking
    if (isBookingSuccessful) {
      _formKey.currentState!.reset();
      setState(() {
        name = '';
        email = '';
        phone = '';
        address = '';
        gender = null;
        numberOfPerson = 1;
        selectedDate = null;
      });
    }
  } catch (error) {
    Navigator.pop(context);
    _showErrorDialog(error.toString());
  }
}

void _showBookingResult(bool isSuccess) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined,
                color: isSuccess ? Colors.green : Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                isSuccess ? 'Booking Confirmed' : 'Booking Failed',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                isSuccess
                    ? 'Thank you, $name! Your booking for ${widget.travel.name} is confirmed.\n\nPlease proceed to the payment page.'
                    : 'Sorry, we couldn’t process your booking. Please try again later.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? Colors.green : Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Book This Travel',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField('Full Name', (value) => name = value!, TextInputType.text),
                _buildTextField('Email', (value) => email = value!, TextInputType.emailAddress),
                _buildTextField('Phone', (value) => phone = value!, TextInputType.phone),
                _buildTextField('Address', (value) => address = value!, TextInputType.text),
                _buildDropdown(),
                _buildTextField('Number of People', (value) => numberOfPerson = int.parse(value!), TextInputType.number),
                _buildDatePicker(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _bookTravel();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved, TextInputType keyboardType) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter your $label',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    ),
  );
}

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: gender,
        items: ['Male', 'Female', 'Other']
            .map((label) => DropdownMenuItem(child: Text(label), value: label))
            .toList(),
        onChanged: (value) {
          setState(() {
            gender = value!;
          });
        },
        decoration: InputDecoration(
          labelText: 'Gender',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: (value) => value == null ? 'Please select your gender' : null,
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Booking Date',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: selectedDate == null
              ? 'Select a date'
              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        onTap: () => _selectDate(context),
        validator: (value) => selectedDate == null ? 'Please select a date' : null,
      ),
    );
  }
}

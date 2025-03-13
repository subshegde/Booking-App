import 'package:flutter/material.dart';

class HotelContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book, Enjoy, Stay Happy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Book your stay, enjoy the comfort, and leave with unforgettable memories.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),

        ],
      ),
    );
  }
}

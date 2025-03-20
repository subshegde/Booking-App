import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/components/customRatingBar.dart';
import 'package:travel_vehicle_planner/components/dynamic_checkboxList.dart';
import 'package:travel_vehicle_planner/components/range_picker.dart';
import 'package:travel_vehicle_planner/components/sliderVertical.dart';
import 'package:travel_vehicle_planner/onboard/onboard_travel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TravelOnBoardingScreen(),
      // home: VerticalOptionSelectionPage(),
    );
  }
}

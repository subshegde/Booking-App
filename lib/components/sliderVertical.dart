import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/common/components/slider.dart';

class VerticalOptionSelectionPage extends StatefulWidget {
  @override
  _VerticalOptionSelectionPageState createState() =>
      _VerticalOptionSelectionPageState();
}

class _VerticalOptionSelectionPageState
    extends State<VerticalOptionSelectionPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> options = [
    {'label': 'Two Wheeler (Bike)', 'icon': Icons.directions_bike},
    {'label': 'Two Wheeler (Scooty)', 'icon': Icons.directions_bike},
    {'label': 'Four Wheeler (Car)', 'icon': Icons.directions_car},
    {'label': 'Four Wheeler (Jeep)', 'icon': Icons.directions_car},
    {'label': 'Cycle (Men)', 'icon': Icons.pedal_bike},
    {'label': 'Cycle (Women)', 'icon': Icons.pedal_bike},
    {'label': 'All', 'icon': Icons.all_inclusive},
    {'label': 'Electric Bike', 'icon': Icons.bolt},
    {'label': 'Electric Scooter', 'icon': Icons.electric_bike},
    {'label': 'Luxury Car', 'icon': Icons.local_car_wash},
    {'label': 'Convertible Car', 'icon': Icons.directions_car},
    {'label': 'Van', 'icon': Icons.local_shipping},
    {'label': 'Bus', 'icon': Icons.directions_bus},
    {'label': 'Pickup Truck', 'icon': Icons.local_shipping},
    {'label': 'Motorcycle', 'icon': Icons.directions_bike},
    {'label': 'Moped', 'icon': Icons.motorcycle},
    {'label': 'ATV (All-Terrain Vehicle)', 'icon': Icons.sports_motorsports},
    {'label': 'Hybrid Car', 'icon': Icons.electric_car},
    {'label': 'SUV', 'icon': Icons.directions_car},
    {'label': 'Minivan', 'icon': Icons.car_repair},
    {'label': 'Scooter (Electric)', 'icon': Icons.electric_scooter},
    {'label': 'Cargo Bike', 'icon': Icons.local_shipping},
    {'label': 'Tricycle', 'icon': Icons.pedal_bike},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            VerticalOptionMenu(
              options: options,
              selectedIndex: _selectedIndex,
              onSelect: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              menuBackgroundColor: Colors.grey[100],
              selectedItemBackgroundColor: Colors.grey[700],
              unselectedItemBackgroundColor: Colors.white,
              selectedItemTextColor: Colors.white,
              unselectedItemTextColor: Colors.black,
              selectedItemIconColor: Colors.white,
              unselectedItemIconColor: Colors.grey,
              itemHeight: 80,
              itemWidth: 100,
              imageType: 'icon',
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Selected Option: ${options[_selectedIndex]['label']}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

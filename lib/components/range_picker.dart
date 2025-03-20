import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/common/components/custom_range_picker.dart';

class FancySliderPage extends StatefulWidget {
  @override
  _FancySliderPageState createState() => _FancySliderPageState();
}

class _FancySliderPageState extends State<FancySliderPage> {
  RangeValues _values = const RangeValues(20, 80);

  // Callback when the interaction starts
  void _onChangeStart(RangeValues values) {
    print("Slider interaction started: $values");
  }

  // Callback when the interaction ends
  void _onChangeEnd(RangeValues values) {
    print("Slider interaction ended: $values");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fancy Custom Range Slider'),
        backgroundColor: Colors.white, // White background for the app bar
        elevation: 0, // Remove the shadow from the app bar
        iconTheme: const IconThemeData(color: Colors.black), // Black icons in the app bar
      ),
      backgroundColor: Colors.white, // White background for the whole page
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Range',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Black color for text
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: Colors.white, // White background for the slider container
                ),
                child: CustomRangeSlider(
                  values: _values,
                  min: 0,
                  max: 100000,
                  divisions: 10,
                  activeColor: Colors.black, // Black for active color
                  inactiveColor: Colors.grey[300]!, // Light grey for inactive color
                  onChanged: (RangeValues values) {
                    setState(() {
                      _values = values;
                    });
                  },
                  overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.3)),
                  mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
                  labels: RangeLabels(
                    '${_values.start.round()}',
                    '${_values.end.round()}',
                  ),
                  semanticFormatterCallback: (value) => '${value.round()} units',
                  onChangeStart: _onChangeStart,  // Pass the onChangeStart callback
                  onChangeEnd: _onChangeEnd,      // Pass the onChangeEnd callback
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Selected Range: ${_values.start.round()} - ${_values.end.round()}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Black text for the selected range
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light().copyWith(
      primaryColor: Colors.black, // Black primary color
      scaffoldBackgroundColor: Colors.white, // White background for scaffold
    ),
    home: FancySliderPage(),
  ));
}

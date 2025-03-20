import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/common/components/check_box_list.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // List of options to display (this can be a dynamic list)
  List<String> options = [
    'Product A',
    'Product B',
    'Product C',
    'Product D',
    'Product E',
  ];

  List<String> selectedItems = [];

  void _onSelectionChanged(List<String> selectedItems) {
    setState(() {
      this.selectedItems = selectedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dynamic Checkbox Selection")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DynamicCheckboxSelection<String>(
          options: options,
          onSelectionChanged: _onSelectionChanged,
          containerHeight: 200,
          containerWidth: 250,
          // You can omit customization if you want to use the default white theme
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExamplePage(),
  ));
}

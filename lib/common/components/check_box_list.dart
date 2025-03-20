import 'package:flutter/material.dart';

class DynamicCheckboxSelection<T> extends StatefulWidget {
  final List<T> options;
  final ValueChanged<List<T>> onSelectionChanged;

  // Customizable parameters for the container, checkbox, and text styles
  final Color containerBackgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color itemTextColor; // Color for selected item text
  final Color unselectedItemTextColor; // Color for unselected item text
  final Color checkboxColor;
  final Color selectedCheckboxColor;
  final Color containerBorderColor;
  final double containerBorderWidth;
  final double containerBorderRadius;
  final Color shadowColor;
  final double containerHeight;
  final double containerWidth;
  final double itemHeight;
  final double itemWidth;

  const DynamicCheckboxSelection({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
    this.containerBackgroundColor = Colors.white, // White background by default
    this.selectedItemColor = Colors.grey, // Light Grey for selected item
    this.unselectedItemColor = Colors.white, // White for unselected item
    this.itemTextColor = Colors.black, // Black text color for selected items
    this.unselectedItemTextColor = Colors.grey, // Grey text color for unselected items
    this.checkboxColor = Colors.grey, // Grey checkbox for unselected state
    this.selectedCheckboxColor = Colors.black, // Black checkbox for selected state
    this.containerBorderColor = Colors.grey, // Light Grey border color
    this.containerBorderWidth = 1.0, // Thin border
    this.containerBorderRadius = 12.0, // Rounded corners
    this.shadowColor = Colors.black26, // Light shadow color
    this.containerHeight = 60.0, // Default container height
    this.containerWidth = double.infinity, // Full width container
    this.itemHeight = 50.0, // Default item height
    this.itemWidth = 200.0, // Default item width
  }) : super(key: key);

  @override
  _DynamicCheckboxSelectionState<T> createState() => _DynamicCheckboxSelectionState<T>();
}

class _DynamicCheckboxSelectionState<T> extends State<DynamicCheckboxSelection<T>> {
  List<T> selectedItems = [];

  // Function to handle the item selection change
  void _onItemSelected(T item, bool selected) {
    setState(() {
      if (selected) {
        selectedItems.add(item);
      } else {
        selectedItems.remove(item);
      }
    });
    widget.onSelectionChanged(selectedItems);
  }

  // Function to determine how to display the item text based on its type
  String _getDisplayText(T item) {
    if (item is String) {
      return item;
    } else if (item is int) {
      return item.toString();
    } else if (item is Map<String, dynamic>) {
      return item.values.join(', '); // Handle a Map
    } else if (item is List) {
      return item.join(', '); // Handle List of objects (like List<String>)
    } else {
      // For custom objects, return the default string representation
      return item.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      decoration: BoxDecoration(
        color: widget.containerBackgroundColor, // White background
        borderRadius: BorderRadius.circular(widget.containerBorderRadius),
        border: Border.all(
          color: widget.containerBorderColor, // Light grey border color
          width: widget.containerBorderWidth, // Thin border width
        ),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor, // Light shadow
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final option = widget.options[index];
          final displayText = _getDisplayText(option);

          return Container(
            width: widget.itemWidth,
            height: widget.itemHeight,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Row(
              children: [
                Checkbox(
                  value: selectedItems.contains(option),
                  onChanged: (bool? selected) {
                    _onItemSelected(option, selected ?? false);
                  },
                  activeColor: widget.selectedCheckboxColor, // Black for selected checkbox
                  checkColor: widget.checkboxColor, // Grey for unselected checkbox
                ),
                Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: selectedItems.contains(option)
                        ? widget.itemTextColor // Black for selected text
                        : widget.unselectedItemTextColor, // Grey for unselected text
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


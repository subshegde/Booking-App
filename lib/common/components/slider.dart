import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class VerticalOptionMenu extends StatelessWidget {
  final List<Map<String, dynamic>> options;
  final ValueChanged<int> onSelect;
  final int selectedIndex;

  // Customizable parameters for dynamic customization
  final Color? menuBackgroundColor; // Menu background color
  final Color? selectedItemBackgroundColor; // Background color of selected item
  final Color? unselectedItemBackgroundColor; // Background color of unselected items
  final Color? selectedItemTextColor; // Text color of selected item
  final Color? unselectedItemTextColor; // Text color of unselected items
  final Color? selectedItemIconColor; // Icon color of selected item
  final Color? unselectedItemIconColor; // Icon color of unselected items
  final double itemHeight;
  final double itemWidth;
  final double navbarHeight;

  final String imageType;

  const VerticalOptionMenu({
    Key? key,
    required this.options,
    required this.onSelect,
    required this.selectedIndex,
    this.menuBackgroundColor = Colors.grey,
    this.selectedItemBackgroundColor = Colors.blue,
    this.unselectedItemBackgroundColor = Colors.white,
    this.selectedItemTextColor = Colors.white,
    this.unselectedItemTextColor = Colors.black,
    this.selectedItemIconColor = Colors.white,
    this.unselectedItemIconColor = Colors.grey,
    this.itemHeight = 80.0,
    this.itemWidth = 70.0,
    this.navbarHeight = 45.0,
    required this.imageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen height excluding the system and app bar heights
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height; // App bar height
    double statusBarHeight = MediaQuery.of(context).padding.top + navbarHeight; // Status bar height
    double availableHeight = screenHeight - appBarHeight - statusBarHeight; // Available space for the menu

    return Container(
      width: itemWidth,
      height: availableHeight, // Adjusted height
      color: menuBackgroundColor ?? Colors.grey[100],
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(
            options[index]['label'],
            options[index]['image'],
            index,
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(String label, dynamic image, int index) {
    bool isSelected = index == selectedIndex;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
      child: GestureDetector(
        onTap: () {
          onSelect(index);
        },
        child: Container(
          width: itemWidth,
          height: itemHeight,
          decoration: BoxDecoration(
            color: isSelected
                ? selectedItemBackgroundColor
                : unselectedItemBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Handling the type of image (icon, asset, network, file, memory, or svg)
              _getImageWidget(image, isSelected),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? selectedItemTextColor
                      : unselectedItemTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageWidget(dynamic image, bool isSelected) {
    switch (imageType) {
      case 'icon':
        return Icon(
          image,
          color: isSelected
              ? selectedItemIconColor
              : unselectedItemIconColor,
          size: 20,
        );
      case 'asset':
        return Image.asset(
          image ?? '',
          width: 24,
          height: 24,
          color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
        );
      case 'network':
        return Image.network(
          image ?? '',
          width: 24,
          height: 24,
          color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
        );
      case 'file':
        return Image.file(
          File(image ?? ''),
          width: 24,
          height: 24,
          color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
        );
      case 'memory':
        return Image.memory(
          image ?? Uint8List(0), // Ensure to pass a valid Uint8List
          width: 24,
          height: 24,
          color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
        );
      case 'svg':
        return SvgPicture.asset(
          image ?? '',
          width: 24,
          height: 24,
          color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
        );
      default:
        return Container();
    }
  }
}

import 'package:flutter/material.dart';

class CustomRatingBar extends StatefulWidget {
  final int totalStars; // Number of stars for the rating bar
  final double initialRating; // Initial rating value (0 to totalStars)
  final ValueChanged<int> onRatingChanged; // Callback to return selected rating value
  final IconData selectedIcon; // Icon for selected star
  final IconData unselectedIcon; // Icon for unselected star

  // Customizable parameters for color, size, and spacing
  final Color selectedColor; // Color for selected icons
  final Color unselectedColor; // Color for unselected icons
  final double gap; // Gap between the icons
  
  // Container Customizations
  final Color containerBackgroundColor; // Background color of the container
  final Color shadowColor; // Shadow color for the container
  final Color borderColor; // Border color for the container
  final double borderRadius; // Border radius for rounded corners
  final double borderWidth; // Border width for the container

  // Direct container and icon size customization parameters
  final double containerWidth; // Width of the container
  final double containerHeight; // Height of the container
  final double iconSize; // Size for the icons

  const CustomRatingBar({
    Key? key,
    required this.totalStars,
    required this.onRatingChanged,
    required this.selectedIcon,
    required this.unselectedIcon,
    this.initialRating = 0.0,
    this.selectedColor = Colors.yellow, // Default selected color is yellow
    this.unselectedColor = Colors.grey, // Default unselected color is grey
    this.gap = 8.0, // Default gap between icons
    this.containerBackgroundColor = Colors.white, // Default container background
    this.shadowColor = Colors.black26, // Default shadow color
    this.borderColor = Colors.grey, // Default border color
    this.borderRadius = 12.0, // Default border radius
    this.borderWidth = 1.0, // Default border width
    this.containerWidth = 250.0, // Default container width
    this.containerHeight = 60.0, // Default container height
    this.iconSize = 30.0, // Default icon size
  }) : super(key: key);

  @override
  _CustomRatingBarState createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  void _onStarTap(int index) {
    setState(() {
      rating = index + 1.0; // Rating will be index + 1, as index is 0-based
    });
    widget.onRatingChanged(rating.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.containerHeight, // Set container height from parameter
      width: widget.containerWidth, // Set container width from parameter
      decoration: BoxDecoration(
        color: widget.containerBackgroundColor, // Container background color
        borderRadius: BorderRadius.circular(widget.borderRadius), // Rounded corners
        border: Border.all(
          color: widget.borderColor, // Border color
          width: widget.borderWidth, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor, // Shadow color
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding around the rating bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.totalStars, (index) {
            bool isSelected = rating > index;
            return GestureDetector(
              onTap: () => _onStarTap(index),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.gap / 2), // Add spacing between icons
                child: Icon(
                  isSelected ? widget.selectedIcon : widget.unselectedIcon,
                  size: widget.iconSize, // Use the icon size passed as a parameter
                  color: isSelected ? widget.selectedColor : widget.unselectedColor,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

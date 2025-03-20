import 'package:flutter/material.dart';

class CustomRangeSlider extends StatelessWidget {
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;
  final ValueChanged<RangeValues>? onChangeStart; // Callback when interaction starts
  final ValueChanged<RangeValues>? onChangeEnd;   // Callback when interaction ends
  final double min;
  final double max;
  final int? divisions;
  final RangeLabels? labels;
  final Color activeColor;
  final Color inactiveColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final WidgetStateProperty<MouseCursor?>? mouseCursor;
  final String Function(double)? semanticFormatterCallback;

  const CustomRangeSlider({
    Key? key,
    required this.values,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.labels,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.overlayColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: values,
      min: min,
      max: max,
      divisions: divisions,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      onChanged: onChanged,
      overlayColor: overlayColor,
      mouseCursor: mouseCursor,
      labels: labels,
      semanticFormatterCallback: semanticFormatterCallback,
      onChangeStart: onChangeStart,  // Pass the onChangeStart callback
      onChangeEnd: onChangeEnd,      // Pass the onChangeEnd callback
    );
  }
}

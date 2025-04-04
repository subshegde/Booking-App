import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';

class CustomConfirmation extends StatelessWidget {
  final String message;
  final String title;
  final Color backgroundColor;
  final IconData iconData;
  final VoidCallback onClose;
  final VoidCallback onNo;
  final VoidCallback onYes;
  final Color color;

  CustomConfirmation({
    required this.message,
    required this.title,
    required this.backgroundColor,
    required this.iconData,
    required this.onClose,
    required this.onNo,
    required this.onYes,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(iconData, color: color, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: onNo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      minimumSize: const Size(120, 40),
                      side: const BorderSide(color: AppColors.black, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'NO',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                    onPressed: onYes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      minimumSize: const Size(120, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'YES',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showCustomConfirmation({
  required BuildContext context,
  required String message,
  required String title,
  required VoidCallback onNo,
  required VoidCallback onYes,
  required Color backgroundColor,
}) async {
  final overlay = Overlay.of(context);
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => CustomConfirmation(
      color: backgroundColor,
      message: message,
      title: title,
      backgroundColor: AppColors.white,
      iconData: Icons.warning,
      onClose: () {
        overlayEntry?.remove();
      },
      onNo: () {
        onNo();
        overlayEntry?.remove();
      },
      onYes: () {
        onYes();
        overlayEntry?.remove();
      },
    ),
  );

  overlay.insert(overlayEntry);
}

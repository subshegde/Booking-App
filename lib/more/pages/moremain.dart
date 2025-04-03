import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/auth/pages/login.dart';
import 'package:travel_vehicle_planner/common/helpers/confirmations/confirmation.dart';
import 'package:travel_vehicle_planner/common/helpers/navigations/appNavigation.dart';
import 'package:travel_vehicle_planner/helpcenter/pages/help.dart';
import 'package:travel_vehicle_planner/profile/pages/profile.dart';

class MoreMainPage extends StatefulWidget {
  const MoreMainPage({super.key});

  @override
  State<MoreMainPage> createState() => _MoreMainPageState();
}

class _MoreMainPageState extends State<MoreMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'More',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _buildActionButton('Payment', Colors.grey[200]!,
                            Colors.black, Icons.payment, 'payment'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: _buildActionButton('Profile', Colors.grey[200]!,
                            Colors.black, Icons.person, 'profile'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _buildActionButton(
                            'Help Center',
                            Colors.grey[200]!,
                            Colors.black,
                            Icons.help,
                            'helpcenter'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: _buildActionButton('Logout', Colors.grey[200]!,
                            Colors.black, Icons.exit_to_app, 'logout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color buttonColor, Color textColor,
      IconData icon, String which) {
    return GestureDetector(
      onTap: () {
        if (which == 'logout') {
          showCustomConfirmation(
            context: context,
            message: 'Are you sure you want to logout?',
            title: 'Logout Confirmation',
            onNo: () {},
            onYes: () {
              doLogout();
            },
          );
        } else if (which == 'payment') {
        } else if (which == 'profile') {
          AppNavigation.push(context, ProfilePage());
          
        } else if (which == 'helpcenter') {
          AppNavigation.push(context, const HelpCenterPage());
        } 
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Icon(icon, color: textColor),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> doLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Get.offAll(() => LoginPage());
  }
}

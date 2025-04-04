import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_vehicle_planner/auth/pages/login.dart';
import 'package:travel_vehicle_planner/common/helpers/confirmations/confirmation.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';
import 'package:travel_vehicle_planner/db/database_helper.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  int? userId;
  String? fullName, photo, username, address, email, phone, role, gender;

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('id');
      fullName = prefs.getString('fullName');
      photo = prefs.getString('photo');
      username = prefs.getString('username');
      address = prefs.getString('address');
      email = prefs.getString('email');
      phone = prefs.getString('phone');
      role = prefs.getString('role');
      gender = prefs.getString('gender');
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        photo = pickedFile.path;
      });
      prefs.setString('photo', photo!);
      final result = await _dbHelper.updateProfileImageInDB(photo, username);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile picture updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        loadUserData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile picture!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> doLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.offAll(() => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildProfileImage(),
                        const SizedBox(height: 16),
                        _buildUserInfo(),
                        const Divider(),
                        const SizedBox(height: 10),
                        _buildDetails(),
                        const SizedBox(height: 20),
                        _buildActionButton(
                          'Logout',
                          AppColors.black,
                          AppColors.white,
                          Icons.exit_to_app,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
          backgroundImage: _imageFile != null
              ? FileImage(_imageFile!)
              : (photo != null
                  ? FileImage(File(photo!))
                  : const AssetImage('assets/default_avatar.png')
                      as ImageProvider),
        ),
        GestureDetector(
          onTap: _pickImage,
          child: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 18,
            child: Icon(Icons.edit, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          fullName ?? 'Loading...',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          role ?? '',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        _buildInfoTile(Icons.abc, 'Name', fullName),
        _buildInfoTile(Icons.person, 'Username', username),
        _buildInfoTile(Icons.email, 'Email', email),
        _buildInfoTile(Icons.phone, 'Phone', phone),
        _buildInfoTile(Icons.home, 'Address', address),
        _buildInfoTile(Icons.transgender, 'Gender', gender),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String? info) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: TextStyle(color: Colors.grey[800])),
      subtitle: Text(info ?? 'Not available'),
    );
  }

  Widget _buildActionButton(
      String label, Color buttonColor, Color textColor, IconData icon) {
    return GestureDetector(
      onTap: () {
        showCustomConfirmation(
          backgroundColor: Colors.black,
          context: context,
          message: 'Are you sure you want to logout?',
          title: 'Logout Confirmation',
          onNo: () {},
          onYes: () {
            doLogout();
          },
        );
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
}

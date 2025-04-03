import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:travel_vehicle_planner/db/database_helper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String selectedGender = 'Male';
  File? _image;
  bool isPasswordVisible = false;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

Future<void> _register() async {
  if (_formKey.currentState!.validate()) {
    bool exists = await _dbHelper.doesEmailOrUsernameExist('johndoe'); 
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email or Username already exists!')),
      );
      return;
    }

    try {
      await _dbHelper.insertUser({
        'fullName': fullNameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'password': passwordController.text,
        'gender': selectedGender,
        'photo': _image?.path ?? '',
      });

      clearFields();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
    } catch (e) {
      print('$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

void clearFields(){
  fullNameController.clear();
  usernameController.clear();
  emailController.clear();
  phoneController.clear();
  addressController.clear();
  passwordController.clear();
  _image = null;
  confirmPasswordController.clear();
  setState(() {});
}


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null ? const Icon(Icons.camera_alt, color: Colors.black54) : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              _buildTextField(
                controller: fullNameController,
                hint: "Full Name",
                icon: Icons.person,
                validator: (value) => value!.isEmpty ? 'Enter full name' : null,
              ),
              const SizedBox(height: 15),

              // Username
              _buildTextField(
                controller: usernameController,
                hint: "Username",
                icon: Icons.account_circle,
                validator: (value) => value!.isEmpty ? 'Enter username' : null,
              ),
              const SizedBox(height: 15),

              // Email
              _buildTextField(
                controller: emailController,
                hint: "Email",
                icon: Icons.email,
                validator: (value) => value!.isEmpty ? 'Enter email' : null,
              ),
              const SizedBox(height: 15),

              // Phone Number
              _buildTextField(
                controller: phoneController,
                hint: "Phone Number",
                icon: Icons.phone,
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              const SizedBox(height: 15),

              // Address
              _buildTextField(
                controller: addressController,
                hint: "Address",
                icon: Icons.home,
                validator: (value) => value!.isEmpty ? 'Enter your address' : null,
              ),
              const SizedBox(height: 15),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                onChanged: (value) => setState(() => selectedGender = value!),
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),              

              // Password
              _buildTextField(
                controller: passwordController,
                hint: "Password",
                icon: Icons.lock,
                obscureText: !isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                ),
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
              ),
              const SizedBox(height: 15),

              // Confirm Password
              _buildTextField(
                controller: confirmPasswordController,
                hint: "Confirm Password",
                icon: Icons.lock,
                obscureText: !isPasswordVisible,
                validator: (value) {
                  if (value!.isEmpty) return 'Confirm password';
                  if (value != passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 30),

              const SizedBox(height: 30),
              MaterialButton(
                onPressed:_register,
                elevation: 0,
                padding: const EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: "Login",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        ),
                      ],
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54),
          prefixIcon: Icon(icon, color: Colors.black54),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

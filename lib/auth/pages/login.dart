import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/auth/pages/signup.dart';
import 'package:travel_vehicle_planner/common/helpers/navigations/appNavigation.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';
import 'package:travel_vehicle_planner/db/database_helper.dart';
import 'package:travel_vehicle_planner/home/pages/home_main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      final userData = await _dbHelper.verifyUserCredentials(email, password);

      if (userData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!'),backgroundColor: AppColors.green,),
        );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('id', userData['id']);
      prefs.setString('fullName', userData['fullName']);
      prefs.setString('photo', userData['photo']);
      prefs.setString('username', userData['username']);
      prefs.setString('address', userData['address']);
      prefs.setString('email', userData['email']);
      prefs.setString('phone', userData['phone']);
      prefs.setString('role', userData['role']);
      prefs.setString('gender', userData['gender']);
      prefs.setBool('isLogin', true);
      
      AppNavigation.pushReplaceMent(context, HomeMainPage());

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password'),backgroundColor: AppColors.errorColor,),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: size.height * 0.2,
            top: size.height * 0.05,
          ),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello, \nWelcome Back",
                  style: TextStyle(
                    fontSize: size.width * 0.1,
                    color: Colors.black,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) => value!.isEmpty ? 'Enter email' : null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        validator: (value) => value!.isEmpty ? 'Enter password' : null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.black54),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            MSHCheckbox(
                              size: 20,
                              value: isChecked,
                              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                checkedColor: Colors.blue,
                              ),
                              style: MSHCheckboxStyle.stroke,
                              onChanged: (selected) {
                                setState(() {
                                  isChecked = selected;
                                });
                              },
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Remember Me',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    MaterialButton(
                      onPressed: _login,
                      elevation: 0,
                      padding: const EdgeInsets.all(18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.black,
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'or',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          width: 30,
                          image: AssetImage('assets/icons/auth/google.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextSpan(
                            text: " Register",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

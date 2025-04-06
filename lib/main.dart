import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/others/onboard/onboard_travel.dart';
import 'package:travel_vehicle_planner/tabs/home/pages/home_main.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  runApp(const MyApp());
}

Future<bool> isLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLogin') ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: 
      // SignInDemo()
       FutureBuilder<bool>(
        future: isLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData && snapshot.data == true) {
              return HomeMainPage();
            } else {
              return const TravelOnBoardingScreen();
            }
          }
        },
      ),
    );
  }
}

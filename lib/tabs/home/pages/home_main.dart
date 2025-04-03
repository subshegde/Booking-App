import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_vehicle_planner/constant/baseurl/baseurl.dart';
import 'package:travel_vehicle_planner/constant/colors/app_colors.dart';
import 'package:travel_vehicle_planner/tabs/home/components/curve_app_bar.dart';
import 'package:travel_vehicle_planner/tabs/home/pages/home.dart';
import 'package:travel_vehicle_planner/tabs/hotel/pages/hotelhome.dart';
import 'package:travel_vehicle_planner/tabs/more/pages/main/moremain.dart';
import 'package:travel_vehicle_planner/tabs/tp/pages/travel_home_screen.dart';
import 'package:travel_vehicle_planner/tabs/vehicle/pages/vehiclemain.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeMainPage extends StatefulWidget {
  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  String? empName = '';

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey travelKey = GlobalKey();
  final GlobalKey hotelKey = GlobalKey();
  final GlobalKey vehiclKey = GlobalKey();
  final GlobalKey moreKey = GlobalKey();

  bool _isTutorialShown = false;

  @override
  void initState() {
    super.initState();
  }


void _showTutorial() {
  TutorialCoachMark(
    targets: _createTargets(),
    colorShadow: Colors.black,
    textSkip: "SKIP",
    textStyleSkip: const TextStyle(
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    paddingFocus: 10,
    opacityShadow: 0.8,
    onSkip: () {
      _markTutorialAsShown();
      return true; 
    },
  ).show(context: context);

  Future.delayed(const Duration(seconds: 3), () {
    _markTutorialAsShown();
  });
}

Future<void> _markTutorialAsShown() async {
  final prefs = await SharedPreferences.getInstance();
  bool isTutorialShown = prefs.getBool('isTutorialShown') ?? false;

  if (!isTutorialShown) {
    await prefs.setBool('isTutorialShown', true);
  }
}

  List<TargetFocus> _createTargets() {
    return [
TargetFocus(
  identify: "Home",
  keyTarget: homeKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.home_rounded,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

               Text(
                "Welcome $empName!",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
               const Text(
                "Your dashboard is your hub for tracking activity and accessing key features:\n\n"
                "Leaves: View your leave balance.\n"
                "Attendance: Check your attendance percentage.\n"
                "Reports: View detailed attendance reports.\n"
                "Logs: Track your check-in/out times.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    controller.next();
                  },
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                  splashRadius: 24,
                  tooltip: "Next",
                ),
              ),
            ],
          ),
        );
      },
    ),
  ],
),
TargetFocus(
  identify: "Travel",
  keyTarget: travelKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E), 
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.access_time_rounded, 
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Travel Planning",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Adventure Awaits",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Adventure awaits in every corner of the world.\n"
                "New places, new perspectives.\n"
                "The world is full of places waiting to be explored.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previous();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24, 
                    tooltip: "Previous",
                  ),

                  IconButton(
                    onPressed: () {
                      controller.next();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Next",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),

TargetFocus(
  identify: "Hotel",
  keyTarget: hotelKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Manage Your Hotels Efficiently",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "A hotel is not just a place to stay, but a destination of comfort and relaxation."
                "Book your luxurious hotel here and enjoy a memorable stay.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previous();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Previous",
                  ),
                  IconButton(
                    onPressed: () {
                      controller.next();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Next",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),
TargetFocus(
  identify: "Vehicle",
  keyTarget: vehiclKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.payment_rounded,
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Access Your Vehicles Easily",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Explore the world in comfort with our top-rated vehicles."
                "Our vehicles provide a smooth and safe journey for all your adventures.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previous();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Previous",
                  ),
                  IconButton(
                    onPressed: () {
                      controller.next();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Next",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),
TargetFocus(
  identify: "More",
  keyTarget: moreKey,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "All Your Bookings in One Place:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "In the 'More' section, you can find all your travel, hotel, and vehicle bookings in one convenient location."
                "Stay organized and on top of your plans, all from your app.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previous();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    splashRadius: 24,
                    tooltip: "Previous",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  ],
),


      
    ];
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }



  Future<bool> _onWillPop(screenWidth) async {
    if (_currentIndex > 0) {
      safeSetSate(() {
        _currentIndex = 0;
      });
      _pageController.jumpToPage(0);
      return Future.value(false);
    } else {
      return await showModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          elevation: 2,
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 190,
                  color: AppColors.white,
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          'Are you sure want to exit ?',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                        tileColor: AppColors.purple,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.newPrimary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          width: screenWidth,
                          height: 40,
                          child: const Center(
                            child: Text(
                              'NO',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                          SystemNavigator.pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: AppColors.newPrimary,
                                  style: BorderStyle.solid,
                                  strokeAlign: BorderSide.strokeAlignInside),
                              color: AppColors.tranperent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0),
                                bottomLeft: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),
                              )),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          width: screenWidth,
                          height: 40,
                          child: const Center(
                              child: Text(
                            'YES',
                            style:
                                TextStyle(color: AppColors.newPrimary, fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }
@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  return WillPopScope(
    onWillPop: () => _onWillPop(screenWidth),
    child: Scaffold(
      
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          safeSetSate(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePage(),
          TravelHomeScreen(),
          HotelMainPage(),
          VehicleMainPage(),
          MoreMainPage(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Image.asset(
                    '${baseurlnavbar}home-active.png',
                    scale: 22,
                    key: homeKey,
                  )
                : Image.asset(
                    '${baseurlnavbar}home-inactive.png',
                    scale: 22,
                    key: homeKey,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Image.asset(
                    '${baseurlnavbar}travel-active.png',
                    scale: 22,
                    key: travelKey,
                  )
                : Image.asset(
                    '${baseurlnavbar}travel-inactive.png',
                    scale: 22,
                    key: travelKey,
                  ),
            label: 'Travel',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? Image.asset(
                    '${baseurlnavbar}hotel-active.png',
                    scale: 22,
                    key: hotelKey,
                  )
                : Image.asset(
                    '${baseurlnavbar}hotel-inactive.png',
                    scale: 22,
                    key: hotelKey,
                  ),
            label: 'Hotel',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? Image.asset(
                    '${baseurlnavbar}vehicle-active.png',
                    scale: 22,
                    key: vehiclKey,
                  )
                : Image.asset(
                    '${baseurlnavbar}vehicle-inactive.png',
                    scale: 22,
                    key: vehiclKey,
                  ),
            label: 'Vehicle',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 4
                ? Image.asset(
                    '${baseurlnavbar}more-active.png',
                    scale: 22,
                    key: moreKey,
                  )
                : Image.asset(
                    '${baseurlnavbar}more-inactive.png',
                    scale: 22,
                    key: moreKey,
                  ),
            label: 'More',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 13),
        selectedItemColor: AppColors.newPrimary,
        unselectedItemColor: AppColors.darkGrey,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
      ),
    ),
  );
}

void onTabTapped(int index) {
  safeSetSate(() {
    _currentIndex = index;
  });
  _pageController.jumpToPage(index);
}

void safeSetSate(VoidCallback fn) {
  if (mounted) {
    setState(() {
      fn();
    });
  }
}
}
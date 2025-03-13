import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/auth/pages/login.dart';
import 'package:travel_vehicle_planner/home/pages/home_main.dart';
import 'package:travel_vehicle_planner/tp/const.dart';
import 'package:travel_vehicle_planner/tp/models/onboard_model.dart';
import 'package:travel_vehicle_planner/tp/pages/travel_home_screen.dart';

class TravelOnBoardingScreen extends StatefulWidget {
  const TravelOnBoardingScreen({super.key});

  @override
  State<TravelOnBoardingScreen> createState() => _TravelOnBoardingScreenState();
}

class _TravelOnBoardingScreenState extends State<TravelOnBoardingScreen> {
  int currentIndex = 0;
  Widget dotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(right: 6),
      width: 30,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: index == currentIndex ? Colors.white : Colors.white54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: onboarding.length,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                onboarding[index].image,
                fit: BoxFit.cover,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomeMainPage(),
                            ),
                            (route) => false);
                      },
                      child: Visibility(
                        visible: onboarding.length - 1 != currentIndex
                            ? true
                            : false,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white54,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          onboarding[currentIndex].name,
                          style: const TextStyle(
                            fontSize: 70,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "We Travelin are ready to help you on\nvacation around Karnataka",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 235,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboarding.length,
                      dotIndicator,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (_) => HomeMainPage(),
                              //     ),
                              //     (route) => false);
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeMainPage(),
                                  ),
                                  );
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 5),
                                    spreadRadius: 15,
                                    blurRadius: 15,
                                  ),
                                ],
                                color: kButtonColor,
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Let's Get Started",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                  },
                              ),
                            ],
                          ),
                        )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

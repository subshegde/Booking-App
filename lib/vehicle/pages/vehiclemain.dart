// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:travel_vehicle_planner/components/seeAll.dart';
// import 'package:travel_vehicle_planner/tp/const.dart';
// import 'package:travel_vehicle_planner/tp/pages/place_detail.dart';
// import 'package:travel_vehicle_planner/tp/widgets/popular_place.dart';
// import 'package:travel_vehicle_planner/tp/widgets/recomendate.dart';
// import 'package:travel_vehicle_planner/vehicle/components/popular_vehicle.dart';
// import 'package:travel_vehicle_planner/vehicle/components/recomend_vehicle.dart';
// import 'package:travel_vehicle_planner/vehicle/models/vehicle_model.dart';
// import 'package:travel_vehicle_planner/vehicle/pages/vehicle_details.dart';


// class VehicleMainPage extends StatefulWidget {
//   const VehicleMainPage({super.key});

//   @override
//   State<VehicleMainPage> createState() => _VehicleMainPageState();
// }

// class _VehicleMainPageState extends State<VehicleMainPage> {
//   int selectedPage = 0;
//   List<IconData> icons = [
//     Iconsax.home1,
//     Iconsax.search_normal,
//     Icons.confirmation_number_outlined,
//     Icons.bookmark_outline,
//     Icons.person_outline,
//   ];

//   List<VehicleModel> popular = vehiclesList.where((element) => element.category == "popular").toList();
//   List<VehicleModel> recomendate = vehiclesList.where((element) => element.category == "recomend").toList();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       // appBar: headerParts(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Popular Vehicles",
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SeeAllPage(pagename: "vehicle",which: "Popular",)));
//                       },
//                       child: const Text(
//                         "See All",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: blueTextColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.only(bottom: 40),
//                 child: Row(
//                   children: List.generate(
//                     popular.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => VehicleDetailScreen(
//                                 vehicleModel: popular[index],
//                               ),
//                             ),
//                           );
//                         },
//                         child: PopularVehicle(
//                           vehicleModel: popular[index],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Recommendations for You",
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SeeAllPage(pagename: "vehicle",which: "Recomended",)));
//                       },
//                       child: const Text(
//                         "See All",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: blueTextColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Column(
//                   children: List.generate(
//                     recomendate.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.only(bottom: 15),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => VehicleDetailScreen(
//                                 vehicleModel: recomendate[index],
//                               ),
//                             ),
//                           );
//                         },
//                         child: RecomendVehicle(
//                           model: recomendate[index],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
        
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   AppBar headerParts() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.white,
//       leadingWidth: 180,
//       leading: Row(
//         children: [
//           const SizedBox(width: 15),
//           const Icon(
//             Iconsax.location,
//             color: Colors.black,
//           ),
//           const SizedBox(width: 5),
//           Text(
//             "Ashwini",
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//               fontWeight: FontWeight.w600,
//               fontSize: 18,
//               color: Colors.black,
//             ),
//           ),
//           const Icon(
//             Icons.keyboard_arrow_down,
//             size: 30,
//             color: Colors.black26,
//           ),
//         ],
//       ),
//       actions: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(
//               color: Colors.black12,
//             ),
//           ),
//           padding: const EdgeInsets.all(7),
//           child: const Stack(
//             children: [
//               Icon(
//                 Iconsax.notification,
//                 color: Colors.black,
//                 size: 30,
//               ),
//               Positioned(
//                 top: 5,
//                 right: 5,
//                 child: CircleAvatar(
//                   radius: 5,
//                   backgroundColor: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 15),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_vehicle_planner/common/components/slider.dart';
import 'package:travel_vehicle_planner/components/seeAll.dart';
import 'package:travel_vehicle_planner/constant/baseurl/baseurl.dart';
import 'package:travel_vehicle_planner/tp/const.dart';
import 'package:travel_vehicle_planner/vehicle/components/popular_vehicle.dart';
import 'package:travel_vehicle_planner/vehicle/components/recomend_vehicle.dart';
import 'package:travel_vehicle_planner/vehicle/models/vehicle_model.dart';
import 'package:travel_vehicle_planner/vehicle/pages/vehicle_details.dart';

class VehicleMainPage extends StatefulWidget {
  const VehicleMainPage({super.key});

  @override
  State<VehicleMainPage> createState() => _VehicleMainPageState();
}

class _VehicleMainPageState extends State<VehicleMainPage> {
  int selectedPage = 0;
  List<IconData> icons = [
    Iconsax.home1,
    Iconsax.search_normal,
    Icons.confirmation_number_outlined,
    Icons.bookmark_outline,
    Icons.person_outline,
  ];

  @override  
  void initState(){
    super.initState();
    vehicles();
    addOptions();
  }

  List<VehicleModel> popular = [];
  List<VehicleModel> recomendate = [];

  List<Map<String, dynamic>> options = [];

  String selectedType = '';

  void vehicles([String type = '']) {
  popular.clear();
  recomendate.clear();

  // Define the condition for filtering
  var condition = type.isEmpty 
      ? (element) => element.category == "popular" || element.category == "recomend" 
      : (element) => element.category == "popular" || element.category == "recomend" && element.type == type;

  // Filter the list
  popular = vehiclesList.where((element) => element.category == "popular" && condition(element)).toList();
  recomendate = vehiclesList.where((element) => element.category == "recomend" && condition(element)).toList();
  
  setState(() {});
}


  int _selectedIndex = 0;

  void addOptions(){
    options = [
    {'label': 'All', 'image': '${baseurlVehicleIcons}all.png'},
    {'label': 'Two Wheeler (Bike)', 'image': '${baseurlVehicleIcons}bike.png'},
    {'label': 'Two Wheeler (Scooty)', 'image': '${baseurlVehicleIcons}scooty.png'},
    {'label': 'Electric', 'image': '${baseurlVehicleIcons}electric_scooty.png'},
    {'label': 'Four Wheeler (Car)', 'image': '${baseurlVehicleIcons}car.png'},
    {'label': 'Four Wheeler (Open Jeep)', 'image': '${baseurlVehicleIcons}open_jeep.png'},
    {'label': 'Four Wheeler (Jeep)', 'image': '${baseurlVehicleIcons}jeep.png'},
    {'label': 'Man cycle', 'image': '${baseurlVehicleIcons}cycle_man.png'},
    {'label': 'Ladybird', 'image': '${baseurlVehicleIcons}cycle_women.png'},
  ];
  setState(() {});
  }

  
  Map<int, String> typeMap = {
    0: '',
    1: 'two-wheeler-bike',
    2: 'two-wheeler-scooty',
    3: 'electric',
    4: 'car',
    5: 'openjeep',
    6: 'jeep',
    7: 'mancycle',
    8: 'ladybird',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: VerticalOptionMenu(
                options: options,
                selectedIndex: _selectedIndex,
                onSelect: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  selectedType = typeMap[index] ?? '';
                  setState(() {});
                  vehicles(selectedType);
                },
                menuBackgroundColor: Colors.grey[100],
                selectedItemBackgroundColor: Colors.grey[700],
                unselectedItemBackgroundColor: Colors.white,
                selectedItemTextColor: Colors.white,
                unselectedItemTextColor: Colors.black,
                selectedItemIconColor: Colors.white,
                unselectedItemIconColor: Colors.grey,
                itemHeight: 80,
                itemWidth: 100,
                navbarHeight:35,
                imageType: 'asset',
              ),
            ),
            
            // Right Content with vertical scroll
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Vehicles",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const SeeAllPage(pagename: "vehicle",which: "Popular",)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: const Text(
                                "See All",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: blueTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Row(
                        children: List.generate(
                          popular.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VehicleDetailScreen(
                                      vehicleModel: popular[index],
                                    ),
                                  ),
                                );
                              },
                              child: PopularVehicle(
                                vehicleModel: popular[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommended",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const SeeAllPage(pagename: "vehicle",which: "Recomended",)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: const Text(
                                "See All",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: blueTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: List.generate(
                          recomendate.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VehicleDetailScreen(
                                      vehicleModel: recomendate[index],
                                    ),
                                  ),
                                );
                              },
                              child: RecomendVehicle(
                                model: recomendate[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar headerParts() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leadingWidth: 180,
      leading: Row(
        children: [
          const SizedBox(width: 15),
          const Icon(
            Iconsax.location,
            color: Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            "Ashwini",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 30,
            color: Colors.black26,
          ),
        ],
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          padding: const EdgeInsets.all(7),
          child: const Stack(
            children: [
              Icon(
                Iconsax.notification,
                color: Colors.black,
                size: 30,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}

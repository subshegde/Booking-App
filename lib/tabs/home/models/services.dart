import 'package:travel_vehicle_planner/constant/baseurl/baseurl.dart';

class Services {
  final String icon, name;

  Services({required this.icon, required this.name});
}

List<Services> services = [
  Services(
    icon: '${baseurlHomePage}travel.png',
    name: 'Travel',
  ),
  Services(
    icon: '${baseurlHomePage}hotel.png',
    name: 'Hotels',
  ),
  Services(
    icon: '${baseurlHomePage}vehicles.png',
    name: 'Vehicles',
  )
];

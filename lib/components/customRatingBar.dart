import 'package:flutter/material.dart';
import 'package:travel_vehicle_planner/common/components/custom_rating_bar.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _rating1 = 0;
  int _rating2 = 0;
  int _rating3 = 0;
  int _rating4 = 0;
  int _rating5 = 0;
  int _rating6 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Rating Bar Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomRatingBar(
              totalStars: 5,
              onRatingChanged: (rating){_rating1 = rating; setState(() {});},
              selectedIcon: Icons.star,
              unselectedIcon: Icons.star_border,
              initialRating: _rating1.toDouble(),
              selectedColor: Colors.yellow,
              unselectedColor: Colors.grey,
              gap: 10.0,
              containerBackgroundColor: Colors.white,
              shadowColor: Colors.black26,
              borderColor: Colors.yellow,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),
            const SizedBox(height: 10,),
            CustomRatingBar(
              totalStars: 5,
              onRatingChanged: (rating){_rating2 = rating; setState(() {});},
              selectedIcon: Icons.pedal_bike,
              unselectedIcon: Icons.pedal_bike_outlined,
              initialRating: _rating2.toDouble(),
              selectedColor: Colors.blue,
              unselectedColor: Colors.grey,
              gap: 10.0,
              containerBackgroundColor: Colors.white,
              shadowColor: Colors.black26,
              borderColor: Colors.blue,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),
            const SizedBox(height: 10,),
            CustomRatingBar(
              totalStars: 5,
              onRatingChanged: (rating){_rating3 = rating; setState(() {});},
              selectedIcon: Icons.car_rental,
              unselectedIcon: Icons.car_rental_outlined,
              initialRating: _rating3.toDouble(),
              selectedColor: Colors.orange,
              unselectedColor: Colors.grey,
              gap: 10.0,
              containerBackgroundColor: Colors.white,
              shadowColor: Colors.black26,
              borderColor: Colors.orange,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),
            const SizedBox(height: 10,),
            CustomRatingBar(
              totalStars: 5,
              onRatingChanged: (rating){_rating4 = rating; setState(() {});},
              selectedIcon: Icons.money,
              unselectedIcon: Icons.money_outlined,
              initialRating: _rating4.toDouble(),
              selectedColor: Colors.pink,
              unselectedColor: Colors.grey,
              gap: 10.0,
              containerBackgroundColor: Colors.white,
              shadowColor: Colors.black26,
              borderColor: Colors.pink,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),
            const SizedBox(height: 10,),
            CustomRatingBar(
              totalStars: 5,
              onRatingChanged: (rating) {
                _rating5 = rating; 
                setState(() {});
              },
              selectedIcon: Icons.favorite,
              unselectedIcon: Icons.favorite_border,
              initialRating: _rating5.toDouble(),
              selectedColor: Colors.red,
              unselectedColor: Colors.grey,
              gap: 10.0,
              containerBackgroundColor: Colors.white,
              shadowColor: Colors.black26,
              borderColor: Colors.red,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),
            const SizedBox(height: 10,),
            CustomRatingBar(
              totalStars: 5,
              onRatingChanged: (rating) {
                _rating6 = rating; 
                setState(() {});
              },
              selectedIcon: Icons.sentiment_very_satisfied,
              unselectedIcon: Icons.sentiment_very_dissatisfied,
              initialRating: _rating6.toDouble(),
              selectedColor: Colors.deepPurple,
              unselectedColor: Colors.grey,
              gap: 10.0,
              containerBackgroundColor: Colors.white,
              shadowColor: Colors.black26,
              borderColor: Colors.deepPurple,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

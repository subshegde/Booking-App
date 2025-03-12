class OnboardModel {
  String image, name;

  OnboardModel({required this.image, required this.name});
}

List<OnboardModel> onboarding = [
   OnboardModel(
    image: 'assets/landing_images/hampi.jpg',
    name: 'Explore Karnataka with us.',
  ),
  OnboardModel(
    image: 'assets/landing_images/mysore.jpg',
    name: "Natural Beauty of Karnataka",
  ),
  OnboardModel(
    image: 'assets/landing_images/jog.jpg',
    name: 'Peacefull Mind in Nature',
  ),
  OnboardModel(
    image: 'assets/landing_images/mountain.jpg',
    name: 'Bright of mountain Range',
  ),
];
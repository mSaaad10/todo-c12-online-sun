class AssetsManager {
  static const String base = 'assets/images/';
  static const String splashLogo = '${base}splash_logo.png';
  static const String routeLogo = '${base}route_logo.png';
  static const String routeImage = '${base}route_image.svg';

  String getImagePathByName(String imageName) {
    return 'assets/images/$imageName';
  }
}

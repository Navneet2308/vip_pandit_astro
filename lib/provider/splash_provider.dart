import 'package:astrologeradmin/services/user_prefences.dart';
import 'package:astrologeradmin/views/dashboard/home_view.dart';
import 'package:astrologeradmin/views/intro_view/intro_view.dart';
import 'package:flutter/material.dart';

import '../views/dashboard/dashboard_view.dart';

class SplashProvider with ChangeNotifier {
  Future<void> navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5)); // Wait for 5 seconds

    PreferencesServices.getPreferencesData(PreferencesServices.isLogin)
        .then((resultValue) {
      if (resultValue == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => DashboardView()),
          // Navigate to HomePage if logged in
          (_) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => IntroView()),
          // Navigate to IntroView if not logged in
          (_) => false,
        );
      }
    });
  }
}

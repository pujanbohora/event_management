import 'package:eventmanagement/screen/booking_details_screen.dart';
import 'package:eventmanagement/screen/home_screen.dart';
import 'package:eventmanagement/screen/login_screen.dart';
import 'package:eventmanagement/screen/my_booking_screen.dart';
import 'package:eventmanagement/screen/setting_screen.dart';
import 'package:eventmanagement/screen/ticket_screen.dart';
import 'package:eventmanagement/screen/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../screen/navigation_screen.dart';
import '../screen/register_screen.dart';
import '../screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splashscreen());

      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case '/homeScreen':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/myBooking':
        return MaterialPageRoute(builder: (_) => const MyBookingHistoryScreen());

      case '/setting':
        return MaterialPageRoute(builder: (_) => const SettingScreen());

      case '/navigation':
        return MaterialPageRoute(
            builder: (_) => const Navigation(
                  currentIndex: 0,
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}

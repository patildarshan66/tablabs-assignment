import 'package:demo_assignment/model/university.dart';
import 'package:demo_assignment/view/screens/login_screen.dart';
import 'package:demo_assignment/view/screens/university_details_screen.dart';
import 'package:demo_assignment/view/screens/university_screen.dart';
import 'package:flutter/material.dart';
import 'route_strings.dart';

class AppRoutes {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.universityRoute:
        bool isUniversityDeeplink = false;
        String universityName = '';
        if (routeSettings.arguments != null) {
          universityName = routeSettings.arguments as String;
          if(universityName.isNotEmpty){
            isUniversityDeeplink = true;
          }
        }
        return MaterialPageRoute(
          builder: (_) => UniversityScreen(
            isUniversityDeeplink: isUniversityDeeplink,
            universityName: universityName,
          ),
        );
      case RoutePath.universityDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => UniversityDetailsScreen(
              data: routeSettings.arguments as University),
        );
      case RoutePath.loginRoute:
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}

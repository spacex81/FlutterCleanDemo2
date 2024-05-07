import 'package:flutter/material.dart';
import 'package:weather/config/router/route_exceptions.dart';
import 'package:weather/constants/routing_constants.dart';
import 'package:weather/modules/splash_screen/splash_screen.dart';
import 'package:weather/modules/weather_screen/weather_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutingConstants.launchScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutingConstants.weatherScreen:
        return MaterialPageRoute(builder: (_) => const WeatherScreen());
      default:
        throw const RouteException('Route not found!');
    }
  }
}

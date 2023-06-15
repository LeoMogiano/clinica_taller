import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/screens/screens.dart';

class AppRoutes {
  static const initialRoute = '/splash';

  static final routes = <Ruta>[
    Ruta(route: '/login', screen: const LoginScreen()),
    Ruta(route: '/home', screen:  const HomeScreen()),
    Ruta(route: '/splash', screen: const SplashScreen()),
    Ruta(route: '/check', screen: const CheckAuthScreen()),
    Ruta(route: '/perfil', screen: const PerfilScreen()),
    /* Ruta(route: '/user', screen: const UserScreen()), */
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in routes) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }
}

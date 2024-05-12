import 'package:flutter/material.dart';
import 'package:examen_juan_lavado/screen/screen.dart';
//trd
class AppRoutes {
  static const initialRoute = 'login';  
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'home': (BuildContext context) => const HomeScreen(),   
    'list': (BuildContext context) => const ListProductScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
    'provider_detail': (BuildContext context) => ProviderDetailScreen(),
    'provider_edit': (BuildContext context) => const ProviderEditScreen(),
    'main': (BuildContext context) => MainScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
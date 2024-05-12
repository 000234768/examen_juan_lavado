import 'package:flutter/material.dart';
import 'package:examen_juan_lavado/routes/app_routes.dart';
import 'package:examen_juan_lavado/services/auth_service.dart';
import 'package:examen_juan_lavado/services/product_service.dart';
import 'package:examen_juan_lavado/services/proveedor_service.dart';
import 'package:examen_juan_lavado/services/categories_service.dart';
import 'package:examen_juan_lavado/theme/my_theme.dart';
import 'package:examen_juan_lavado/providers/category_provider.dart'; 
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => ProveedorService()),
        ChangeNotifierProvider(create: (_) => CategoryService()), // Agrega el provider de categorías
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyTheme.myTheme,
    );
  }
}

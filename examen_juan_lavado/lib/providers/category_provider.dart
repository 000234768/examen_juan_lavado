import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_juan_lavado/services/categories_service.dart';

class CategoryProvider extends StatelessWidget {
  final Widget child;

  const CategoryProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryService(),
      child: child,
    );
  }

  static CategoryService of(BuildContext context, {bool listen = true}) =>
      Provider.of<CategoryService>(context, listen: listen);
}

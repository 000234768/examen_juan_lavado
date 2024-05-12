import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:examen_juan_lavado/models/category.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Category> categories = [];
  bool isLoading = true;

  CategoryService() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'Authorization': basicAuth});
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['Listado Categorias'];
      print('Received data: $data');
      categories = data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories. Status code: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:examen_juan_lavado/models/proveedor.dart';

class ProveedorService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Proveedor> proveedores = [];
  bool isLoading = true;

  ProveedorService() {
    loadProveedores();
  }

  Future<void> loadProveedores() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'Authorization': basicAuth});
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['Proveedores Listado'];
      print('Received data: $data');
      proveedores = data.map((json) => Proveedor.fromMap(json)).toList();
      print('Proveedores loaded successfully: $proveedores');
    } else {
      throw Exception('Failed to load proveedores. Status code: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }
}

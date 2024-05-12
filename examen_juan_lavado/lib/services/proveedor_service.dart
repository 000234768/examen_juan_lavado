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
  Future<void> addProveedor(String nombre, String apellido, String correo, String estado) async {
  final url = Uri.http(
    _baseUrl,
    'ejemplos/provider_add_rest/',
  );

  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

  final response = await http.post(
    url,
    headers: {
      'Authorization': basicAuth,
      'Content-Type': 'application/json', // Especifica el tipo de contenido del cuerpo
    },
    body: jsonEncode({
      'provider_name': nombre,
      'provider_last_name': apellido,
      'provider_mail': correo,
      'provider_state': estado,
    }),
  );

  if (response.statusCode == 200) {
    print('Proveedor agregado exitosamente');
    // Puedes recargar la lista de proveedores después de agregar uno nuevo
    await loadProveedores();
  } else {
    throw Exception('Error al agregar proveedor. Status code: ${response.statusCode}');
  }
}
Future<void> editProveedor(int id, String nombre, String apellido, String correo, String estado) async {
  final url = Uri.http(
    _baseUrl,
    'ejemplos/provider_edit_rest/',
  );

  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

  final response = await http.post(
    url,
    headers: {
      'Authorization': basicAuth,
      'Content-Type': 'application/json', // Especifica el tipo de contenido del cuerpo
    },
    body: jsonEncode({
      'provider_id': id,
      'provider_name': nombre,
      'provider_last_name': apellido,
      'provider_mail': correo,
      'provider_state': estado,
    }),
  );

  if (response.statusCode == 200) {
    print('Proveedor editado exitosamente');
    // Puedes recargar la lista de proveedores después de editar uno
    await loadProveedores();
  } else {
    throw Exception('Error al editar proveedor. Status code: ${response.statusCode}');
  }
}
Future<void> deleteProveedor(int id) async {
  final url = Uri.http(
    _baseUrl,
    'ejemplos/provider_del_rest/',
  );

  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

  final response = await http.post(
    url,
    headers: {
      'Authorization': basicAuth,
      'Content-Type': 'application/json', // Especifica el tipo de contenido del cuerpo
    },
    body: jsonEncode({
      'provider_id': id,
    }),
  );

  if (response.statusCode == 200) {
    print('Proveedor eliminado exitosamente');
    // Puedes recargar la lista de proveedores después de eliminar uno
    await loadProveedores();
  } else {
    throw Exception('Error al eliminar proveedor. Status code: ${response.statusCode}');
  }
}


}



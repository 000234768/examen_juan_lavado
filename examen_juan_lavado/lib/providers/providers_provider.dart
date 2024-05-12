import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:examen_juan_lavado/models/proveedor.dart';
import 'package:examen_juan_lavado/screen/provider_detail_screen.dart';

class ProviderListScreen extends StatefulWidget {
  final Function(Proveedor) onTap;

  ProviderListScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  _ProviderListScreenState createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {
  late List<Proveedor> proveedores;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    proveedores = [];
    fetchProveedores();
  }

  Future<void> fetchProveedores() async {
    setState(() {
      isLoading = true;
    });
    final url = 'http://143.198.118.203:8050/ejemplos/provider_list_rest/';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final proveedoresList = parsed['Proveedores Listado'] as List<dynamic>;
        setState(() {
          proveedores = proveedoresList.map((json) => Proveedor.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load proveedores');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Proveedores'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: proveedores.length,
              itemBuilder: (context, index) {
                final proveedor = proveedores[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('${proveedor.nombre} ${proveedor.apellido}'),
                    subtitle: Text(proveedor.correo),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            
                            print('Editar proveedor ${proveedor.nombre}');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                          
                            print('Eliminar proveedor ${proveedor.nombre}');
                          },
                        ),
                      ],
                    ),
                    onTap: () => widget.onTap(proveedor),
                  ),
                );
              },
            ),
    );
  }
}

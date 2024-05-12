import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_juan_lavado/services/proveedor_service.dart';
import 'package:examen_juan_lavado/models/proveedor.dart';

class ProviderDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);

    return Scaffold(
      body: Consumer<ProveedorService>(
        builder: (context, proveedorService, child) {
          if (proveedorService.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (proveedorService.proveedores.isEmpty) {
            return Center(child: Text('No hay datos del proveedor'));
          } else {
            final proveedores = proveedorService.proveedores;
            final totalItems = proveedores.length;
            final maxItemsPerPage = 10; // Número máximo de elementos por página
            final totalPages = (totalItems / maxItemsPerPage).ceil();

            return Scaffold(
              appBar: AppBar(
                title: Text('Proveedores (${proveedores.length})'),
              ),
              body: ListView.builder(
                itemCount: proveedores.length,
                itemBuilder: (context, index) {
                  final proveedor = proveedores[index];
                  return ProviderDetailBody(proveedor: proveedor);
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // Lógica para el botón flotante
                },
                child: Icon(Icons.add),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            );
          }
        },
      ),
    );
  }
}

class ProviderDetailBody extends StatelessWidget {
  final Proveedor proveedor;

  const ProviderDetailBody({required this.proveedor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ${proveedor.id}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar el proveedor
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar el proveedor
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Icon(Icons.person, size: 100),
            const SizedBox(height: 10),
            Text('Nombre: ${proveedor.nombre} ${proveedor.apellido}'),
            Text('Correo: ${proveedor.correo}'),
            Text('Estado: ${proveedor.estado}'),
          ],
        ),
      ),
    );
  }
}

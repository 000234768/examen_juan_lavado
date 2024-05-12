import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_juan_lavado/services/proveedor_service.dart';
import 'package:examen_juan_lavado/models/proveedor.dart';

class ProviderDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Proveedores')),
      body: Consumer<ProveedorService>(
        builder: (context, service, child) {
          if (service.isLoading) return Center(child: CircularProgressIndicator());
          if (service.proveedores.isEmpty) return Center(child: Text('No hay datos del proveedor'));

          return ListView.builder(
            itemCount: service.proveedores.length,
            itemBuilder: (context, index) {
              final proveedor = service.proveedores[index];
              return ProviderDetailBody(proveedor: proveedor);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (_) => AddProveedorDialog()),
        child: Icon(Icons.add),
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
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ID: ${proveedor.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => showDialog(context: context, builder: (_) => EditProveedorDialog(proveedor: proveedor)),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _confirmDeletion(context, proveedor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.account_circle, size: 60),
            ),
            const SizedBox(height: 10),
            Text('Nombre: ${proveedor.nombre} ${proveedor.apellido}', style: TextStyle(fontSize: 18)),
            Text('Correo: ${proveedor.correo}', style: TextStyle(fontSize: 16)),
            Text('Estado: ${proveedor.estado}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _confirmDeletion(BuildContext context, Proveedor proveedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que quieres eliminar a este proveedor?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar el diálogo de confirmación
                final service = Provider.of<ProveedorService>(context, listen: false);
                await service.deleteProveedor(proveedor.id);
              },
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
class AddProveedorDialog extends StatelessWidget {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _correoController = TextEditingController();
  final _estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar Proveedor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nombreController, decoration: InputDecoration(labelText: 'Nombre')),
            TextField(controller: _apellidoController, decoration: InputDecoration(labelText: 'Apellido')),
            TextField(controller: _correoController, decoration: InputDecoration(labelText: 'Correo')),
            TextField(controller: _estadoController, decoration: InputDecoration(labelText: 'Estado')),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
        ElevatedButton(
          onPressed: () async {
            await Provider.of<ProveedorService>(context, listen: false).addProveedor(
              _nombreController.text,
              _apellidoController.text,
              _correoController.text,
              _estadoController.text,
            );
            Navigator.of(context).pop();
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}

class EditProveedorDialog extends StatefulWidget {
  final Proveedor proveedor;

  const EditProveedorDialog({required this.proveedor, Key? key}) : super(key: key);

  @override
  _EditProveedorDialogState createState() => _EditProveedorDialogState();
}

class _EditProveedorDialogState extends State<EditProveedorDialog> {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController correoController;
  late TextEditingController estadoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.proveedor.nombre);
    apellidoController = TextEditingController(text: widget.proveedor.apellido);
    correoController = TextEditingController(text: widget.proveedor.correo);
    estadoController = TextEditingController(text: widget.proveedor.estado);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Proveedor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreController, decoration: InputDecoration(labelText: 'Nombre')),
            TextField(controller: apellidoController, decoration: InputDecoration(labelText: 'Apellido')),
            TextField(controller: correoController, decoration: InputDecoration(labelText: 'Correo')),
            TextField(controller: estadoController, decoration: InputDecoration(labelText: 'Estado')),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
        ElevatedButton(
          onPressed: () async {
            await Provider.of<ProveedorService>(context, listen: false).editProveedor(
              widget.proveedor.id,
              nombreController.text,
              apellidoController.text,
              correoController.text,
              estadoController.text,
            );
            Navigator.of(context). pop();
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}

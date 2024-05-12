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
                  // Mostrar el diálogo para agregar un nuevo proveedor
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddProveedorDialog();
                    },
                  );
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

class AddProveedorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    final correoController = TextEditingController();
    final estadoController = TextEditingController();

    return AlertDialog(
      title: Text('Agregar Proveedor'),
      content: SingleChildScrollView( // Envuelve el contenido con SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: estadoController,
              decoration: InputDecoration(labelText: 'Estado'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Cerrar el diálogo
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Agregar el proveedor utilizando los valores de los campos
            final proveedorService = Provider.of<ProveedorService>(context, listen: false);
            await proveedorService.addProveedor(
              nombreController.text,
              apellidoController.text,
              correoController.text,
              estadoController.text,
            );
            // Cerrar el diálogo
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
      content: SingleChildScrollView( // Envuelve el contenido con SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: estadoController,
              decoration: InputDecoration(labelText: 'Estado'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Cerrar el diálogo
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Editar el proveedor utilizando los valores de los campos
            final proveedorService = Provider.of<ProveedorService>(context, listen: false);
            await proveedorService.editProveedor(
              widget.proveedor.id,
              nombreController.text,
              apellidoController.text,
              correoController.text,
              estadoController.text,
            );
            // Cerrar el diálogo
            Navigator.of(context).pop();
          },
          child: Text('Guardar'),
        ),
      ],
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
                    // Mostrar el diálogo para editar el proveedor
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditProveedorDialog(proveedor: proveedor);
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    // Lógica para eliminar el proveedor
                    final proveedorService = Provider.of<ProveedorService>(context, listen: false);
                    await proveedorService.deleteProveedor(proveedor.id);
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

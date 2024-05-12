import 'package:flutter/material.dart';
import 'package:examen_juan_lavado/models/proveedor.dart';

class ProviderEditScreen extends StatelessWidget {
  final Proveedor? proveedor;

  const ProviderEditScreen({this.proveedor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Proveedor'),
      ),
      body: ProviderEditBody(proveedor: proveedor),
    );
  }
}

class ProviderEditBody extends StatelessWidget {
  final Proveedor? proveedor;

  const ProviderEditBody({this.proveedor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.person,
            size: 100,
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: '${proveedor?.nombre ?? ''} ${proveedor?.apellido ?? ''}',
            decoration: const InputDecoration(labelText: 'Nombre completo'),
            onChanged: (value) {
              // Aquí podrías actualizar el nombre y apellido del proveedor
            },
          ),
          TextFormField(
            initialValue: proveedor?.correo ?? '',
            decoration: const InputDecoration(labelText: 'Correo electrónico'),
            onChanged: (value) {
              // Aquí podrías actualizar el correo del proveedor
            },
          ),
          SwitchListTile(
            value: proveedor?.estado == 'Activo',
            onChanged: (value) {
              // Aquí podrías actualizar el estado del proveedor
            },
            title: const Text('Estado activo'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Aquí podrías enviar la solicitud de actualización del proveedor
            },
            child: const Text('Guardar cambios'),
          ),
        ],
      ),
    );
  }
}

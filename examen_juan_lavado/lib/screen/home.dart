import 'package:flutter/material.dart';
import 'package:examen_juan_lavado/screen/screen.dart';
import 'package:examen_juan_lavado/routes/app_routes.dart'; // Importa el archivo donde defines tus rutas

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: true, // Esto mostrará el botón de retroceso en el AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'list');
                  },
                  child: Text('Productos'),
                ),
                Text('|'),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'main'); 
                  },
                  child: Text('Categorías'),
                ),
                Text('|'),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'provider_detail');
                  },
                  child: Text('Proveedores'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListProductScreen(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '2024 Todos los derechos reservados Juan Lavado',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

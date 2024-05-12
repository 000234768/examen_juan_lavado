import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_juan_lavado/providers/category_provider.dart'; 
import 'package:examen_juan_lavado/services/categories_service.dart';
import 'package:examen_juan_lavado/models/category.dart'; 

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: CategoryWidget(),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accede al provider de categorías
    final categoryProvider = Provider.of<CategoryService>(context);
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blueGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorías',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          // Muestra la lista de categorías obtenida del provider
          Expanded(
            child: ListView.builder(
              itemCount: categoryProvider.categories.length,
              itemBuilder: (context, index) {
                final category = categoryProvider.categories[index];
                return CategoryCard(category: category);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({required this.category, Key? key}) : super(key: key);

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
                  'ID: ${category.categoryId}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Lógica para editar la categoría
                      },
                    ),
                    SizedBox(width: 8), // Espaciado entre los íconos
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Lógica para eliminar la categoría
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Nombre: ${category.categoryName}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Estado: ${category.categoryState}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

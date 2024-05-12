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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Mostrar el diálogo para agregar una nueva categoría
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddCategoryDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddCategoryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryNameController = TextEditingController();

    return AlertDialog(
      title: Text('Agregar Categoría'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryNameController,
              decoration: InputDecoration(labelText: 'Nombre de la categoría'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Obtener el nombre de la categoría ingresado por el usuario
            String categoryName = categoryNameController.text;

            // Agregar la categoría utilizando el servicio correspondiente
            final categoryService = Provider.of<CategoryService>(context, listen: false);
            await categoryService.addCategory(categoryName);

            // Cerrar el diálogo
            Navigator.of(context).pop();
          },
          child: Text('Guardar'),
        ),
      ],
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
    final categoryService = Provider.of<CategoryService>(context, listen: false);

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
                        // Mostrar el diálogo para editar la categoría
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditCategoryDialog(category: category);
                          },
                        );
                      },
                    ),
                    SizedBox(width: 8), // Espaciado entre los íconos
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Eliminar la categoría
                        _showDeleteConfirmationDialog(context, categoryService, category.categoryId);
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

  Future<void> _showDeleteConfirmationDialog(BuildContext context, CategoryService categoryService, int categoryId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está seguro de que desea eliminar esta categoría?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                try {
                  await categoryService.deleteCategory(categoryId);
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error al eliminar la categoría: $e');
                  // Mostrar un mensaje de error al usuario si es necesario
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class EditCategoryDialog extends StatefulWidget {
  final Category category;

  const EditCategoryDialog({required this.category, Key? key}) : super(key: key);

  @override
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  late TextEditingController categoryNameController;

  @override
  void initState() {
    super.initState();
    categoryNameController = TextEditingController(text: widget.category.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context, listen: false);

    return AlertDialog(
      title: Text('Editar Categoría'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: categoryNameController,
              decoration: InputDecoration(labelText: 'Nombre de la categoría'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await categoryService.editCategory(widget.category.categoryId, categoryNameController.text, widget.category.categoryState);
              Navigator.of(context).pop();
            } catch (e) {
              print('Error al editar la categoría: $e');
              // Mostrar un mensaje de error al usuario si es necesario
            }
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}

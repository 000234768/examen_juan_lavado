import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_juan_lavado/services/categories_service.dart';
import 'package:examen_juan_lavado/models/category.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categorías')),
      body: CategoryWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (context) => AddCategoryDialog()),
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddCategoryDialog extends StatelessWidget {
  final TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar Categoría'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: categoryNameController, decoration: InputDecoration(labelText: 'Nombre de la categoría')),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
        ElevatedButton(
          onPressed: () async {
            String categoryName = categoryNameController.text;
            final categoryService = Provider.of<CategoryService>(context, listen: false);
            await categoryService.addCategory(categoryName);
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
    final categoryService = Provider.of<CategoryService>(context);
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Categorías: ${categoryService.categories.length}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: categoryService.categories.length,
              itemBuilder: (context, index) {
                final category = categoryService.categories[index];
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
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ID: ${category.categoryId}', style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(icon: Icon(Icons.edit), onPressed: () => showDialog(context: context, builder: (_) => EditCategoryDialog(category: category))),
                IconButton(icon: Icon(Icons.delete), onPressed: () => _showDeleteConfirmationDialog(context, category)),
              ],
            ),
            SizedBox(height: 10),
            Text('Nombre: ${category.categoryName}', style: TextStyle(color: Colors.black54)),
            Text('Estado: ${category.categoryState}', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar esta categoría?'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
            TextButton(
              onPressed: () async {
                final categoryService = Provider.of<CategoryService>(context, listen: false);
                await categoryService.deleteCategory(category.categoryId);
                Navigator.of(context).pop();
              },
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
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
            }
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}

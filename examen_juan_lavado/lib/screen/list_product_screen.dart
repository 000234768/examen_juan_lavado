import 'package:flutter/material.dart';
import 'package:examen_juan_lavado/models/productos.dart';
import 'package:examen_juan_lavado/services/product_service.dart';
import 'package:examen_juan_lavado/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:examen_juan_lavado/services/services.dart';
import 'package:examen_juan_lavado/widgets/widgets.dart';
import 'package:examen_juan_lavado/screen/screen.dart';

class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Total Productos: ${productService.products.length}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productService.products.length,
              itemBuilder: (BuildContext context, index) => GestureDetector(
                onTap: () {
                  productService.SelectProduct =
                      productService.products[index].copy();
                  Navigator.pushNamed(context, 'edit');
                },
                child: ProductCard(product: productService.products[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.SelectProduct = Listado(
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage:
                'https://abravidro.org.br/wp-content/uploads/2015/04/sem-imagem4.jpg',
            productState: '');
          Navigator.pushNamed(context, 'edit');
        },
      ),
    );
  }
}

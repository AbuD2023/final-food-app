import 'package:flutter/material.dart';
import 'package:food_app/Controller/firestore_firebase_cloud/product_firebase.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/screens/firebase/add_product_to_firebase_creen.dart';
import 'package:food_app/screens/firebase/edit_product_to_firebase_creen.dart';

class ProductListFirebaseFutuercreen extends StatelessWidget {
  const ProductListFirebaseFutuercreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductFirebase productFirebase = ProductFirebase();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List with Futuer'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productFirebase.getAllProductsAsFutuer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('خطاء:\n وصف الخطاء-> ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لاتوجد اي بيانات'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  onLongPress: () =>
                      customShowDialog(context: context, product: product),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProductScreen(
                                docId: product.id.toString(),
                                product: product,
                              ))),
                  leading: Image.asset(product.image!),
                  title: Text(product.title!),
                  subtitle:
                      Text('Price: \$${product.price}, Rate: ${product.rate}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to EditProductScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProductScreen(
                            docId: product.id.toString(),
                            product: product,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddProductScreen())),
      ),
    );
  }

  customShowDialog(
      {required BuildContext context, required ProductModel product}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?\n to delete? ${product.title} Product'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () async =>
                await ProductFirebase().deleteProductById(product.id!).then(
              (value) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product deleted successfully'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_app/Controller/firebase_colc/product_firebase.dart';
import 'package:food_app/model/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final String docId;
  final ProductModel product;

  const EditProductScreen({super.key, required this.docId, required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductFirebase _productFirebase = ProductFirebase();

  late String _title;
  late String _image;
  late double _price;
  late double _rate;

  @override
  void initState() {
    super.initState();
    _title = widget.product.title!;
    _image = widget.product.image!;
    _price = widget.product.price!;
    _rate = widget.product.rate!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _image,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (value) => _image = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.tryParse(value ?? '')!,
              ),
              TextFormField(
                initialValue: _rate.toString(),
                decoration: const InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _rate = double.tryParse(value ?? '')!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ProductModel updatedProduct = ProductModel(
                      image: _image,
                      title: _title,
                      price: _price,
                      rate: _rate,
                    );
                    _productFirebase.updateProduct(
                        widget.docId, updatedProduct);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

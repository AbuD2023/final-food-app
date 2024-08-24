import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/Controller/firestore_firebase_cloud/product_firebase.dart';
import 'package:food_app/model/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductFirebase _productFirebase = ProductFirebase();

  String? _title;
  final String _image = 'assets/images/pro2.png';
  double? _price;
  double? _rate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value,
              ),
              
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.tryParse(value ?? ''),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _rate = double.tryParse(value ?? ''),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Random random = Random();
                    int randomNumber = random.nextInt(15827389);
                    ProductModel product = ProductModel(
                      id: randomNumber,
                      image: _image,
                      title: _title!,
                      price: _price!,
                      rate: _rate!,
                    );
                    _productFirebase.addProduct(product);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

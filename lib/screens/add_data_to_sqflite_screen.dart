import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/Controller/Database/database_helper.dart';
import 'package:food_app/model/product_model.dart';

class AddDataToFirebaseScreen extends StatefulWidget {
  const AddDataToFirebaseScreen({super.key});

  @override
  State<AddDataToFirebaseScreen> createState() =>
      _AddDataToFirebaseScreenState();
}

class _AddDataToFirebaseScreenState extends State<AddDataToFirebaseScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Insert dataBase'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Title';
                }
                return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your price';
                }
                return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: rateController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your rate';
                }
                return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Rate',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  // final db = await DatabaseHelper.create();
                  ProductModel product = ProductModel(
                    id: Random(60).nextInt(1000),
                    image: 'assets/images/pro2.png',
                    title: titleController.text,
                    price: double.parse(priceController.text),
                    rate: double.parse(rateController.text),
                  );
                  DatabaseHelper.insertFood(product);
                  log.log('save on datbase');
                  setState(() {});
                },
                child: const Text('Save')),
            FutureBuilder<List>(
              future: DatabaseHelper.getFood(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.hasError) {
                  return const Center(
                    child: Text('لا توجد بيانات'),
                  );
                } else {
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return ListTile(
                          title: Text(data['title']),
                          trailing: CircleAvatar(
                            child: Image.asset(data['image']),
                          ),
                          subtitle: Row(
                            children: [
                              Text('price: ${data['price']}'),
                              const SizedBox(
                                width: 15,
                              ),
                              Text('rate: ${data['rate']}'),
                              const SizedBox(
                                width: 15,
                              ),
                              Text('id: ${data['id']}'),
                            ],
                          ),
                          onTap: () async {
                            // await DatabaseHelper.create();
                            await DatabaseHelper.deleteFoodById(data['id']);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('تم الحذف بنجاح')));
                            setState(() {});
                          },
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/Controller/database_helper.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/widgets/custom_text_fild.dart';

class InsertDatabsae extends StatefulWidget {
  const InsertDatabsae({super.key});

  @override
  State<InsertDatabsae> createState() => _InsertDatabsaeState();
}

class _InsertDatabsaeState extends State<InsertDatabsae> {
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
          title: Text('Insert dataBase'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFild(controller: titleController),
              CustomTextFild(controller: priceController),
              CustomTextFild(controller: rateController),
              ElevatedButton(
                  onPressed: () async {
                    final db = await DatabaseHelper.create();
                    ProductModel productModel = ProductModel(
                      image: 'assets/images/pro2.png',
                      title: titleController.text,
                      price: double.parse(priceController.text),
                      rate: double.parse(rateController.text),
                    );
                    DatabaseHelper.insertFood(productModel, db);
                    log('save on datbase');
                    setState(() {});
                  },
                  child: Text('Save')),
              FutureBuilder<List>(
                future: DatabaseHelper.getFood(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.hasError) {
                    return Center(
                      child: Text('لا توجد بيانات'),
                    );
                  } else {
                    final data = snapshot.data;
                    log('${data}');
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(data[index]['title']),
                          trailing: CircleAvatar(
                            child: Image.asset(data[index]['image']),
                          ),
                          subtitle: Row(
                            children: [
                              Text('price: ${data[index]['price']}'),
                              SizedBox(
                                width: 15,
                              ),
                              Text('rate: ${data[index]['rate']}'),
                              SizedBox(
                                width: 15,
                              ),
                              Text('id: ${data[index]['id']}'),
                            ],
                          ),
                          onTap: () async {
                            await DatabaseHelper.create();
                            await DatabaseHelper.deleteFoodById(
                                data[index]['id'].toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('تم الحذف بنجاح')));
                            setState(() {});
                          },
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

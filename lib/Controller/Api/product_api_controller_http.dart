import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/constants/api_url.dart';
import 'package:food_app/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductApiControllerWithHttp with ChangeNotifier {


  Future<List<ProductModel>> getProductesOnApi() async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.url}Product'));

      if (response.statusCode == 200) {
        final List<dynamic> chatRoomJson = json.decode(response.body);
        final product =
            chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
        // _product =
        //     chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
        // notifyListeners();
        return product;
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductesByIdOnApi(int id) async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.url}$id'));

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> chatRoomJson = json.decode(response.body);
        final product =
            chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
        // _product =
        // chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
        // notifyListeners();
        return product;
      } else {
        throw Exception('Failed to load product By Id');
      }
    } catch (e) {
      // log(e.toString());
      rethrow;
    }
  }

  Future<void> postProductOnApi(ProductModel productModel) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiUrl.url}Product'),
        headers: {'Content-Type': 'application/json'},
        body: productModel.toJson(),
        // body: jsonEncode({
        //   "id": 0,
        //   "image": productModel.image,
        //   "title": productModel.title,
        //   "price": productModel.price,
        //   "rate": productModel.rate,
        // }),
      );
      if (response.statusCode == 201) {
        // _product.add(productModel);
        // log(response.body);
        // notifyListeners();
      } else {
        throw Exception('Failed to post product');
      }
    } catch (e) {
      // log(e.toString());
      rethrow;
    }
  }

  Future<void> postProductOnApiAndUploadImage(
      String title, double price, double rate, XFile? selectedImage) async {
    log('selectedImage: ${selectedImage?.path}');

    // قراءة الصورة وتحويلها إلى بايتات
    File imageFile = File(selectedImage!.path);
    Uint8List imageBytes = await imageFile.readAsBytes();
    // imageBytes = imageBytes.buffer.asUint8List();
    try {
      // Save the data and upload the image to the server/api
      final response = await http.post(
        Uri.parse('${ApiUrl.url}Product'),
        headers: {'Content-Type': 'application/json'},
        // --- 1
        // data: productModel.toJson(),
        // --- 2
        body: jsonEncode({
          "id": 0,
          "image": imageBytes.buffer.asUint8List(),
          "title": title,
          "price": price,
          "rate": rate,
        }),
      );
      if (response.statusCode == 201) {
        // _product.add(productModel);
        // log(response.body);
        print('Upload Response: ${response.body}');
        // notifyListeners();
      } else {
        throw Exception('Failed to post product');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> putProductOnApi(ProductModel productModel) async {}
  Future<void> deleteProductOnApi(int id) async {}
}

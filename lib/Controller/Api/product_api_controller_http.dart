import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/constants/api_url.dart';
import 'package:food_app/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductApiControllerWithHttp with ChangeNotifier {
  Future<List<ProductModel>> getProductesOnApi() async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.url}products'));

      if (response.statusCode == 200) {
        final List<dynamic> chatRoomJson = json.decode(response.body);
        final product =
            chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
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
      final response = await http.get(Uri.parse('${ApiUrl.url}products/$id'));

      if (response.statusCode == 200) {
        log(response.body);
        final List<dynamic> chatRoomJson = json.decode(response.body);
        final product =
            chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
        return product;
      } else {
        throw Exception('Failed to load product By Id');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> postProductOnApiAndUploadImage(
      String title, double price, double rate, XFile? selectedImage) async {
    log('selectedImage: ${selectedImage?.path}');

    // قراءة الصورة وتحويلها إلى بايتات byte لتخزينها في عمود Image في API
    final bytes = await selectedImage!.readAsBytes();
    final base64String = base64Encode(bytes);

    try {
      // Save the data and upload the image to the server/api
      final response = await http.post(
        Uri.parse('${ApiUrl.url}products'),
        headers: {'Content-Type': 'application/json'},
        // --- 1
        body: jsonEncode({
          "id": 0,
          "image": base64String,
          "title": title,
          "price": price,
          "rate": rate,
        }),
      );
      if (response.statusCode == 201) {
        log('Upload Response: ${response.body}');
      } else {
        throw Exception('Failed to post product');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> putProductOnApi(ProductModel productModel) async {}
  Future<void> deleteProductOnApi(int id) async {
    try {
      // Save the data and upload the image to the server/api
      final response =
          await http.delete(Uri.parse('${ApiUrl.url}products/$id'));
      if (response.statusCode == 201) {
        log('Delet from id($id) don 👍');
      } else {
        throw Exception('Failed to Delete id($id)');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}

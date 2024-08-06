import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/api_url.dart';
import 'package:food_app/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductApiControllerWithDio with ChangeNotifier {
  // List<ProductModel> _product = [];
  // List<ProductModel> get prodact => _product;
  late Dio dio;
  ProductApiControllerWithDio() {
    dio = Dio();
  }
  Future<List<ProductModel>> getProductesOnApi() async {
    String url = '${ApiUrl.url}products';
    try {
      Response response = await dio.get(
        url,
      );

      if (response.statusCode == 200) {
        print(response.data);
        final List<dynamic> chatRoomJson = json.decode(response.data);
        // --- 1
        final product =
            chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
        log(response.data);
        // --- 2
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
    String url = '${ApiUrl.url}products/$id';
    try {
      Response response = await dio.get(
        url,
      );

      if (response.statusCode == 200) {
        print(response.data);
        final List<dynamic> chatRoomJson = json.decode(response.data);
        // --- 1
        final product =
            chatRoomJson.map((json) => ProductModel.fromJson(json)).toList();
        // --- 2
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
    String url = '${ApiUrl.url}products';
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: productModel.toJson(),
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
        log(response.data);
        // notifyListeners();
      } else {
        throw Exception('Failed to post product');
      }
    } catch (e) {
      log(e.toString());
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
      final response = await dio.post(
        '${ApiUrl.url}products',
        options: Options(headers: {'Content-Type': 'application/json'}),
        // --- 1
        // data: productModel.toJson(),
        // --- 2
        data: jsonEncode({
          "id": 0,
          "image": imageBytes,
          "title": title,
          "price": price,
          "rate": rate,
        }),
      );
      print('Upload Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> putProductOnApi(ProductModel productModel) async {}
  Future<void> deleteProductOnApi(int id) async {}
}

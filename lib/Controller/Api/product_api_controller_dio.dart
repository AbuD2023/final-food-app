import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/api_url.dart';
import 'package:food_app/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductApiControllerWithDio with ChangeNotifier {
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

        return product;
      } else {
        throw Exception('Failed to load product By Id');
      }
    } catch (e) {
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
      final response = await dio.post(
        '${ApiUrl.url}products',
        options: Options(headers: {'Content-Type': 'application/json'}),
        // إسناد البيانات لكي يتم حفضها في الـ API
        data: jsonEncode({
          "Id": 0,
          "Image": base64String,
          "Title": title,
          "Price": price,
          "Rate": rate,
        }),
      );
      print('Upload Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> putProductOnApi(
      {required int id,
      required String title,
      required double price,
      required double rate,
      required String image,
      required XFile? selectedImage}) async {
    log('selectedImage: ${selectedImage?.path}');

    // قراءة الصورة وتحويلها إلى بايتات byte لتخزينها في عمود Image في API

    final bytes = await selectedImage?.readAsBytes();
    final base64String = base64Encode(bytes ?? []);

    try {
      // Save the data and upload the image to the server/api
      final response = await dio.put(
        '${ApiUrl.url}products/$id',
        options: Options(headers: {'Content-Type': 'application/json'}),
        // إسناد البيانات لكي يتم حفضها في الـ API
        data: jsonEncode({
          "Id": id,
          "Image": selectedImage != null ? base64String : image,
          "Title": title,
          "Price": price,
          "Rate": rate,
        }),
      );
      print('Upload Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteProductOnApi(int id) async {}
}

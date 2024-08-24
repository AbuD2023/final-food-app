import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCardProduct extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final double rate;
  const CustomCardProduct(
      {super.key,
      required this.image,
      required this.title,
      required this.price,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        elevation: 5,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Image.memory(
                base64Decode(image),
                height: 180,
                width: 180,
                fit: BoxFit.contain,
                // اذا لم يتم تحميل الصورة بشكل جيد او اذا لم تكن هناك صورة يتم عرض صورة من الملفات
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  // اذا كانت الصورة من sqflite
                  image.startsWith('assets/')
                      ? image
                      : 'assets/images/pro2.png',
                  height: 180,
                  width: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Rs.$price',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xffFF470B),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text('$rate/5'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> _decodeBase64Image() async {
    try {
      // محاولة تحويل الصورة من Base64
      return base64Decode(image);
    } catch (e) {
      // في حال حدوث خطأ، سيتم عرض الصورة البديلة
      return null;
    }
  }
}

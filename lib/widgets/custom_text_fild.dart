import 'package:flutter/material.dart';

class CustomTextFild extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextFild({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }
}

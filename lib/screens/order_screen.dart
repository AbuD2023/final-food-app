import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/widgets/custom_button.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F8),
        title: const Text(
          'Order',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Avocado.png'),
          const Text(
            'No orders yet',
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Hit the orange button down \n below to Create an order',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 47,
          ),
          Center(
            child: CustomButton(
                text: 'Start odering',
                onTap: () {},
                backgroundColor: AppColors.kPrimaryColor,
                textColor: Colors.white),
          )
        ],
      ),
    );
  }
}

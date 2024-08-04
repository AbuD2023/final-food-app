import 'package:flutter/material.dart';

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
              Image.asset(
                image,
                height: 180,
                width: 180,
                fit: BoxFit.contain,
              ),
              SizedBox(
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Rs.${price}',
                    style: TextStyle(
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
}

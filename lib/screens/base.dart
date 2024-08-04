import 'package:flutter/material.dart';
import 'package:food_app/screens/add_data_to_database_screen.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/image_screen.dart';
import 'package:food_app/screens/order_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int selectIndex = 0;

  List screen = [
    HomeScreen(),
    OrderScreen(),
    CartScreen(),
    ImageScreen(),
    InsertDatabsae(),
  ];

  // واحده من الطرق لعرض الشاشة في body
  // screen.elementAt(selectIndex)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home.png'), label: ''),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/cart.png'), label: ''),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/favarite.png'), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.image,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: ''),
        ],
        onTap: (value) {
          setState(() {
            selectIndex = value;
          });
        },
      ),
    );
  }
}

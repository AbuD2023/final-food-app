import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/sign_in_screen.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../constants/app_string.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      log('${FirebaseAuth.instance.currentUser}');
      Navigator.of(context).pushNamed(FirebaseAuth.instance.currentUser == null
          ? "SignInScreen"
          : "base_screen");
    });
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Stack(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(AppImages.kCofee)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 44),
                child: Text(
                  AppString.kFoodForEveryone,
                  style: TextStyle(
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 160.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/images/burger.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset('assets/images/ice_cream.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 390.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 314,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Yum Bites',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Pacifico',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset('assets/images/noodles.png'),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'assets/images/Frame.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 300.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/taco.png',
                height: 140,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

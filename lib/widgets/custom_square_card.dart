import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomSquareCard extends StatelessWidget {
  const CustomSquareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      width: 172,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.kPrimaryColor,
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 16, right: 19, top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '50%',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'off',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.kWhite,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Text(
              'on all sushi orders \n across app*',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '*Terms and conditions applied',
                style: TextStyle(color: AppColors.kWhite, fontSize: 7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

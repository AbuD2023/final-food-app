import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String? image;
  final Function() onTap;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.backgroundColor,
      this.image,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 64,
        width: 350,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Image.asset(
                    image ?? '',
                    height: 24,
                    width: 24,
                  )
                : const SizedBox(),
            SizedBox(
              width: 6,
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

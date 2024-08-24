import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    // Animation<double>? opacity = (value / 1000).clamp(0, 1);
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'testing github',
            style: TextStyle(),
          ),
          Center(
            child: CachedNetworkImage(
              height: 200,
              width: 200,
              imageUrl: 'http://via.placeholder.com/350x150',
              placeholder: (context, url) => const SpinKitWave(
                color: Colors.red,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

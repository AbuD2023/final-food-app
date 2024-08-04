import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/Controller/Api/product_api_controller_dio.dart';
import 'package:food_app/Controller/Api/product_api_controller_http.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/constants/app_images.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/widgets/custom_card_product.dart';
import 'package:food_app/widgets/custom_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_square_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  late ProductApiControllerWithDio _productApiControllerWithDio;
  late ProductApiControllerWithHttp _productApiControllerWithHttp;

  // get image on device
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  // function to pick image on device
  Future<void> _pickImage(ImageSource imageSource) async {
    final XFile? image = await _picker.pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _productApiControllerWithDio = ProductApiControllerWithDio();
    _productApiControllerWithHttp = ProductApiControllerWithHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[300],
          ),
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                label: Text(
                  'Search',
                  style: TextStyle(fontSize: 17, color: Colors.black),
                )),
          ),
        ),
        // leading: Image.asset('assets/icons/drawer.png'),
        actions: [Image.asset('assets/icons/person.png')],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.kPrimaryColor,
        child: ListView(
          children: [
            DrawerHeader(
                child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            )),
            CustomListTile(image: AppImages.kIconSetting, title: 'Settings'),
            CustomListTile(
                image: 'assets/icons/scan_code.png', title: 'Scan Code'),
            CustomListTile(image: 'assets/icons/wallet.png', title: 'Wallet'),
            CustomListTile(image: 'assets/icons/offers.png', title: 'Offers'),
            CustomListTile(image: 'assets/icons/help.png', title: 'Help'),
            CustomListTile(image: 'assets/icons/help.png', title: 'Help'),
            CustomListTile(
                image: 'assets/icons/rate.png', title: 'Rate the app'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSquareCard(),
                CustomSquareCard(),
              ],
            ),
            const SizedBox(height: 26),
            Container(
              height: 138,
              width: 358,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff333333),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 58, top: 33, bottom: 33),
                child: Text(
                  'Use code \niLovemyfood \nto get 10% off on your orders',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Foods',
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.kPrimaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.kPrimaryColor,
                    decorationThickness: 3,
                  ),
                ),
                Text(
                  'Drinks',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff9A9A9D),
                  ),
                ),
                Text(
                  'Snacks',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff9A9A9D),
                  ),
                ),
                Text(
                  'Sauce',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff9A9A9D),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder<List<ProductModel>>(
                future: _productApiControllerWithHttp.getProductesOnApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];

                        // log(data.image.toString());

                        List<int> imageBytesList =
                            List<int>.from(data.image.cast<int>());

                        Uint8List imageBytes =
                            Uint8List.fromList(imageBytesList);
                        return CustomCardProduct(
                          image: imageBytes,
                          title: data.title!,
                          price: data.price!,
                          rate: data.rate!,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customShowDailog();
        },
        child: Icon(Icons.food_bank_outlined),
        backgroundColor: AppColors.kPrimaryColor,
      ),
    );
  }

  customShowDailog() {
    showDialog(
      // barrierColor: AppColors.kPrimaryColor[400],
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kPrimaryColor[50],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: Icon(Icons.add_photo_alternate)),
                IconButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: Icon(Icons.add_a_photo)),
              ],
            ),
            Text('Add new food'),
          ],
        ),
        actions: [
          SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: titleController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Title';
              }
              return null;
            },
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your price';
              }
              return null;
            },
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: rateController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your rate';
              }
              return null;
            },
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Rate',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor[200]),
                  onPressed: () async {
                    await _productApiControllerWithDio
                        .postProductOnApiAndUploadImage(
                            titleController.text,
                            double.parse(priceController.text),
                            double.parse(rateController.text),
                            _selectedImage?.path != null
                                ? _selectedImage
                                : null);
                  },
                  child: Text(
                    'Add To Api',
                    style: TextStyle(color: Colors.white),
                  ))),
        ],
      ),
    );
  }
}

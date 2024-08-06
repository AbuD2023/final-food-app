// import 'package:flutter/material.dart';
// import 'package:food_app/constants/app_colors.dart';
// import 'package:image_picker/image_picker.dart';

// // تم إنشاء الداله لكي اقوم باستخدامها اكثر من مرة في عملية الضافة والتعديل
// customShowDailog(context, pickImage, ImageSource, titleController,
//     priceController, rateController, VoidCallback onPressed, titleButton) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       backgroundColor: AppColors.kPrimaryColor[50],
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               IconButton(
//                   onPressed: () => pickImage(ImageSource.gallery),
//                   icon: Icon(Icons.add_photo_alternate)),
//               IconButton(
//                   onPressed: () => pickImage(ImageSource.camera),
//                   icon: Icon(Icons.add_a_photo)),
//             ],
//           ),
//           Text('Add new food'),
//         ],
//       ),
//       actions: [
//         SizedBox(
//           height: 25,
//         ),
//         TextFormField(
//           controller: titleController,
//           keyboardType: TextInputType.text,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter your Title';
//             }
//             return null;
//           },
//           obscureText: false,
//           decoration: InputDecoration(
//             labelText: 'Title',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             filled: true,
//             fillColor: Colors.grey[200],
//           ),
//         ),
//         SizedBox(
//           height: 25,
//         ),
//         TextFormField(
//           controller: priceController,
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter your price';
//             }
//             return null;
//           },
//           obscureText: false,
//           decoration: InputDecoration(
//             labelText: 'Price',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             filled: true,
//             fillColor: Colors.grey[200],
//           ),
//         ),
//         SizedBox(
//           height: 25,
//         ),
//         TextFormField(
//           controller: rateController,
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter your rate';
//             }
//             return null;
//           },
//           obscureText: false,
//           decoration: InputDecoration(
//             labelText: 'Rate',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             filled: true,
//             fillColor: Colors.grey[200],
//           ),
//         ),
//         SizedBox(
//           height: 25,
//         ),
//         Center(
//             child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.kPrimaryColor[200]),
//                 onPressed: onPressed,
//                 child: Text(
//                   titleButton,
//                   style: TextStyle(color: Colors.white),
//                 ))),
//       ],
//     ),
//   );
// }

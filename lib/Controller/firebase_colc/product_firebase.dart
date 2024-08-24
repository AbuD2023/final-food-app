import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/model/product_model.dart';

class ProductFirebase {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  // Futuer لعرض كل المنتجات
  Future<List<ProductModel>> getAllProductsAsFutuer() async {
    QuerySnapshot snapshot = await productCollection.get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(
        doc.data() as Map<String, dynamic>,
        docId: doc.id,
      );
    }).toList();
  }

  // Stream لجلب كل المنتجات مع التحديث المستمر
  Stream<List<ProductModel>> getAllProductsAsStream() {
    return productCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromJson(
          doc.data() as Map<String, dynamic>,
          docId: doc.id,
        );
      }).toList();
    });
  }

  // إضافة منتج جديد
  Future<void> addProduct(ProductModel product) async {
    await productCollection.add(product.toJson());
  }

  // تعديل منتج
  Future<void> updateProduct(String docId, ProductModel product) async {
    await productCollection.doc(docId).update(product.toJson());
  }

  // حذف منتج محدد بواسطة docId
  Future<void> deleteProductByDocId(String docId) async {
    await productCollection.doc(docId).delete();
  }

  // حذف منتج باستخدام الحقل id
  Future<void> deleteProductById(int id) async {
    try {
      // البحث عن الوثيقة التي تحتوي على الحقل id
      QuerySnapshot snapshot =
          await productCollection.where('id', isEqualTo: id).get();

      if (snapshot.docs.isNotEmpty) {
        // حذف الوثيقة بعد العثور عليها
        await snapshot.docs.first.reference.delete();
      } else {
        log("No document found with the given id");
      }
    } catch (e) {
      log("Error deleting document: $e");
    }
  }

  // الحصول على منتج محدد بواسطة ID المحدد باستخدام Futuer
  Future<ProductModel?> getProductAsFutuerById(String docId) async {
    DocumentSnapshot doc = await productCollection.doc(docId).get();
    if (doc.exists) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

// الحصول على منتج محدد بواسطة ID المحدد باستخدام Stream
  Stream<ProductModel?> getProductAsStreamById(String docId) {
    return productCollection.doc(docId).snapshots().map((doc) {
      if (doc.exists) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }
}

import 'dart:developer';

import 'package:food_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute('''
CREATE TABLE IF NOT EXISTS Product(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  image TEXT,
  title TEXT,
  price float,
  rate float
);
CREATE TABLE IF NOT EXISTS user(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT,
  password TEXT,
  address TEXT,
  phone TEXT
);
''');
  }

  static Future<sql.Database> create() async {
    return sql.openDatabase(
      'fooddb.db',
      version: 1,
      onCreate: (sql.Database db, version) {
        createTable(db);
      },
    );
  }

  static Future<int> insertFood(
      ProductModel productModel) async {
    final db = await DatabaseHelper.create();
    final data = {
      'image': productModel.image,
      'title': productModel.title,
      'price': productModel.price,
      'rate': productModel.rate,
    };
    final id = await db.insert(
      'Product',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, Object?>>> getFood() async {
    final db = await DatabaseHelper.create();
    return db.query('Product', orderBy: 'id');
  }

  static Future<List<Map<String, Object?>>> getFoodById(int id) async {
    final db = await DatabaseHelper.create();
    return db.query('Product', where: "id ?", whereArgs: [id]);
  }

  static Future<void> deleteFoodById(int id) async {
    final db = await DatabaseHelper.create();
    try {
      await db.delete('Product', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      log('error: $e');
    }
  }
}

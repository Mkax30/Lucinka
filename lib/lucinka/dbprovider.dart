import 'dart:async';
import 'dart:io';

import 'package:path/path.dart'; //used to join paths
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:sqflite/sqflite.dart'; //sqflite package

import 'product_model.dart'; //import model class

class ProductDbProvider {

  ProductDbProvider._();

  static final ProductDbProvider instance = ProductDbProvider._();

  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a dir
    // ectory which stores permanent files
    final path = join(directory.path, "product.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE Products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          mj TEXT,
          price TEXT)""");
    });
  }

  Future<int> addItem(ProductModel item) async {
    //returns number of items inserted as an integer
    final db = await init(); //open database
    return db.insert(
      "Products", item.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<ProductModel>> fetchProducts() async {
    //returns the memos as a list (array)
    final db = await init();
    final maps = await db
        .query("Products"); //query all the rows in a table as an array of maps
    return List.generate(maps.length, (i) {
      //create a list of memos
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        mj: maps[i]['mj'],
        price: maps[i]['price'],
      );
    });
  }

  Future<int> deleteProduct(int id) async {
    //returns number of items deleted
    final db = await init();
    int result = await db.delete("Products", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    return result;
  }

  Future<int> updateProduct(int id, ProductModel item) async {
    // returns the number of rows updated
    final db = await init();
    int result = await db
        .update("Products", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}

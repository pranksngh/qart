

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qart/Models/Products.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  


   static late Database _database;

   static Future<Database> get database async {
     final databasePath = await getDatabasesPath();
     final status = await databaseExists(databasePath);

     if(!status){
       _database = await openDatabase(join(databasePath, 'products.db'),
       onCreate: (database, version){
            return   database.execute('CREATE TABLE ProductInfo('
          'id INTEGER PRIMARY KEY,'
          'Season TEXT,'
          'Brand TEXT,'
          'Option TEXT,'
          'QRCode TEXT,'
          'Color TEXT,'
          'AvailableSizes TEXT,'
          'ImageUrl TEXT,'
          'MRP DOUBLE,'
          'Collection Text,'
          'Category TEXT,'
          'Fit TEXT,'
          'Gender TEXT,'
          'Likeabilty DOUBLE,'
          'Mood TEXT,'
          'OfferMonths TEXT,'
          'TechnologyImageUrl TEXT,'
          'Description TEXT,'
          'Theme TEXT,'
          'Finish Text,'
          'SubCategory Text,'
          'Name Text,'
          'EAN TEXT'

          ')');
       },
       version:1
       );
     }
      return _database;
   }


 Future createProduct(Products newProduct) async {
    await deleteProducts();
    final db = await database;

    final res = await db.insert('ProductInfo', newProduct.toJson());
       print('Data inserted $res');
    return res; 
  }


 
  Future fetchProducts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM ProductInfo");
    List<dynamic> list = res;

   print(list);

   return list;
   
  }

   Future deleteProducts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM ProductInfo');


   print(res);
   
  }
}
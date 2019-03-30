import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:just_buy_flutter/page/goods/models/good.dart';
import 'package:just_buy_flutter/page/categories/category.dart';


class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  AppDatabase._internal();

  Database _dataBase;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  Future<Database> getDb() async {
    if (!didInit) await _init();
    print("getdb");
    return _dataBase;
  }

  Future _init() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "goods.db");
    _dataBase = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
      await _createCategoryTable(db);
      await _createGoodTable(db);
    },onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${Category.tblCategory}");
      await db.execute("DROP TABLE ${Goods.tblGood}");
      await _createCategoryTable(db);
      await _createGoodTable(db);
    });
    didInit = true;
  }
  
  Future _createGoodTable(Database db) {
    return db.execute("CREATE TABLE ${Goods.tblGood} ("
        "${Goods.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Goods.dbName} TEXT,"
        "${Goods.dbImg} TEXT,"
        "${Goods.dbNum} INTEGER,"
        "${Goods.dbPrice} Single,"
        "${Goods.dbTax} Single,"
        "${Goods.dbDiscount} Single,"
        "${Goods.dbLocalRate} Single,"
        "${Goods.dbBuyTime} LONG,"
        "${Goods.dbOwner} TEXT,"
        "${Goods.dbRemark} TEXT,"
        "${Goods.dbCategoryID} INTEGER,"
        "FOREIGN KEY(${Goods.dbCategoryID}) REFERENCES ${Category.tblCategory}(${Category.dbId}) ON DELETE CASCADE);");
  }

  Future _createCategoryTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Category.tblCategory} ("
          "${Category.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Category.dbName} TEXT,"
          "${Category.dbImg} TEXT,"
          "${Category.dbColorName} TEXT,"
          "${Category.dbColorCode} INTEGER);"
      );
      for (var x in Category.allCategory()){
        txn.rawInsert('INSERT INTO '
        '${Category.tblCategory}(${Category.dbId},${Category.dbName},${Category.dbColorName},${Category.dbColorCode},${Category.dbImg})'
        ' VALUES(' + x.id.toString() + ', "' + x.name + '", ' + '"' + x.colorName + '",' + x.colorValue.toString() + ',"' + x.image + '"'+ ');');
      }

    });
  }
}


import 'package:just_buy_flutter/db/app_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:just_buy_flutter/page/categories/category.dart';

class CategoryDB {
  static final CategoryDB _categoryDB = CategoryDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  CategoryDB._internal(this._appDatabase);

  static CategoryDB get() {
    return _categoryDB;
  }

  Future<List<Category>> getCategories() async {
    var db = await _appDatabase.getDb();
    var result =
        await db.rawQuery('SELECT * FROM ${Category.tblCategory};');
    List<Category> categories = List();
    for (Map<String, dynamic> item in result) {
      var myCategory = Category.fromMap(item);
      categories.add(myCategory);
    }
    return categories;
  }

  Future insertOrReplace(Category category) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
        '${Category.tblCategory}(${Category.dbId},${Category.dbName},${Category.dbImg},${Category.dbColorCode},${Category.dbColorName})'
      ' VALUES(${category.id},"${category.name},"${category.image}",${category.colorValue},"${category.colorName}")');
    });
  }

  Future deleteCategory(int categoryID) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
        'DELETE FROM ${Category.tblCategory} WHERE ${Category.dbId}==$categoryID;');
    });
  }
}
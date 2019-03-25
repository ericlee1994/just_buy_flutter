import 'package:sqflite/sqflite.dart';
import 'package:just_buy_flutter/db/app_db.dart';
import 'package:just_buy_flutter/page/goods/models/good.dart';
import 'package:just_buy_flutter/page/categories/category.dart';

class GoodDB {
  static final GoodDB _goodDb = GoodDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  GoodDB._internal(this._appDatabase);

  static GoodDB get() {
    return _goodDb;
  }

  Future<List<Goods>> getGoods() async {
    var db = await _appDatabase.getDb();
    var result =
        await db.rawQuery('SELECT ${Goods.tblGood}.* FROM ${Goods.tblGood};');

    return _bindData(result);
  }

  List<Goods> _bindData(List<Map<String, dynamic>> result) {
    List<Goods> goods = List();
    for (Map<String, dynamic> item in result) {
      var myGood = Goods.fromMap(item);
      myGood.categoryName = item[Category.dbName];
      myGood.categoryColor = item[Category.dbColorCode];
      goods.add(myGood);
    }
    return goods;
  }

  Future updateGood(Goods good) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Goods.tblGood}(${Goods.dbId},${Goods.dbName},${Goods.dbCategoryID},${Goods.dbTax},'
          '${Goods.dbPrice},${Goods.dbDiscount},${Goods.dbBuyTime},${Goods.dbOwner},'
          '${Goods.dbRemark},${Goods.dbImg},${Goods.dbLocalRate},${Goods.dbNum})'
          ' VALUES(${good.id},${good.name},${good.categoryId},${good.tax},'
          '${good.price},${good.discount},${good.time},${good.owner},'
          '${good.remark},${good.img},${good.localRate},${good.num})');
    });
  }

  Future deleteGood(int goodID) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          "DELETE FROM ${Goods.tblGood} WHERE ${Goods.dbId}=$goodID;");
    });
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:just_buy_flutter/page/goods/models/good.dart';

final String tableGoods = 'Goods';
final String columnId = '_id';
final String columnName = 'name';
final String columnImage = 'image';
final String columnNum = 'num';
final String columnPrice = 'price';
final String columnTax = 'tax';
final String columnDiscount = 'discount';
final String columnLR = 'localRate';
final String columnTime = 'time';
final String columnOwner = 'owner';
final String columnRemark = 'remark';

//class Todo {
//  int id;
//  String title;
//  bool done;
//
//  Map<String, dynamic> toMap() {
//    var map = <String, dynamic>{
//      columnTitle: title,
//      columnDone: done == true ? 1 : 0
//    };
//    if (id != null) {
//      map[columnId] = id;
//    }
//    return map;
//  }
//
//  Todo();
//
//  Todo.fromMap(Map<String, dynamic> map) {
//    id = map[columnId];
//    title = map[columnTitle];
//    done = map[columnDone] == 1;
//  }
//}

class Good {
  var id;
  var name;
  var image;
  int num;
  double price;
  var tax;
  var discount;
  var localRate;
  var time;
  var owner;
  var remark;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnImage: image,
      columnNum: num,
      columnPrice: price,
      columnTax: tax,
      columnDiscount: discount,
      columnLR: localRate,
      columnTime: time,
      columnOwner: owner,
      columnRemark: remark
    };
    return map;
  }

  Good.fromMap(Map<String, dynamic> map) {
    name = map[columnName];
    image = map[columnImage];
    num = map[columnNum];
    price = map[columnPrice];
    tax = map[columnTax];
    discount = map[columnDiscount];
    localRate = map[columnLR];
    time = map[columnTime];
    owner = map[columnOwner];
    remark = map[columnRemark];
  }

  Good(this.name, this.image, this.num, this.price, this.tax, this.discount,
      this.localRate, this.time, this.owner, this.remark);

  static List<Good> allGood(){
    var good = List<Good>();

    good.add(Good("ipad", "images/digital.png", 1, 6700.36, 0, 0, 0, 0, "Eric", ""));
    good.add(Good("ipad", "images/digital.png", 1, 6700.36, 0, 0, 0, 0, "Eric", ""));
    good.add(Good("ipad", "images/digital.png", 1, 6700.36, 0, 0, 0, 0, "Eric", ""));
    good.add(Good("ipad", "images/digital.png", 1, 6700.36, 0, 0, 0, 0, "Eric", ""));
    good.add(Good("ipad", "images/digital.png", 1, 6700.36, 0, 0, 0, 0, "Eric", ""));
    good.add(Good("ipad", "images/digital.png", 1, 6700.36, 0, 0, 0, 0, "Eric", ""));

    return good;
  }
}

class GoodProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableGoods (
      $columnId integer primary key autoincrement,
      $columnName text not null,
      $columnImage text not null,
      $columnNum integer not null
      $columnPrice real not null,
      $columnDiscount real not null,
      $columnLR real not null,
      $columnTime text not null,
      $columnOwner text not null,
      $columnRemark text ,)
      ''');
    });
  }

  Future<Good> insert(Good good) async {
    good.id = await db.insert(tableGoods, good.toMap());
    return good;
  }

  Future<Good> getGood(int id) async {
    List<Map> maps = await db.query(tableGoods,
        columns: [columnId, columnName, columnImage, columnNum,
        columnPrice, columnDiscount, columnLR, columnTime,
        columnOwner, columnRemark],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Good.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableGoods, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Good good) async {
    return await db.update(tableGoods, good.toMap(),
        where: '$columnId = ?', whereArgs: [good.id]);
  }

  Future close() async => db.close();
}

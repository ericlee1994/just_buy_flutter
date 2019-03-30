import 'package:meta/meta.dart';

class Goods {
  static final tblGood = "Goods";
  static final dbId = "id";
  static final dbName = "name";
  static final dbImg = "image";
  static final dbNum = "number";
  static final dbPrice = "price";
  static final dbTax = "tax";
  static final dbDiscount = "discount";
  static final dbLocalRate = "localrate";
  static final dbBuyTime = "buyTime";
  static final dbCategoryID = "categoryId";
  static final dbOwner = "owner";
  static final dbRemark = "remark";

  var name;
  var img;
  int id, num, categoryId, categoryColor;
  var price;
  var tax;
  var discount;
  var localRate;
  var time;
  var owner;
  var remark;
  String categoryName;

  Goods.create(
      {this.name,
      this.img,
      this.num,
      this.price,
      this.tax,
      this.discount,
      this.localRate,
      this.time = -1,
      this.owner,
      this.remark,
      this.categoryId}) {
    if (this.time == -1) {
      this.time = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Goods.update(
      {@required this.id,
      this.name,
      this.img,
      this.num,
      this.price,
      this.tax,
      this.discount,
      this.localRate,
      this.time = -1,
      this.owner,
      this.remark,
      this.categoryId}) {
    if (this.time == -1) {
      this.time = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Goods.fromMap(Map<String, dynamic> map)
      : this.update(
          id: map[dbId],
          name: map[dbName],
          img: map[dbImg],
          num: map[dbNum],
          price: map[dbPrice],
          tax: map[dbTax],
          discount: map[dbDiscount],
          localRate: map[dbLocalRate],
          time: map[dbBuyTime],
          owner: map[dbOwner],
          remark: map[dbRemark],
          categoryId: map[dbCategoryID],
        );
}

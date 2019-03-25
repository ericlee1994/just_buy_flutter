import 'package:flutter/material.dart';

class Category {
  static final tblCategory = "categorys";
  static final dbId = "cg_id";
  static final dbName = "cg_name";
  static final dbImg = "cg_image";
  static final dbColorCode = "cg_colorCode";
  static final dbColorName = "cg_colorName";

  var image;
  String name, colorName;
  int id, colorValue;

  Category(this.image, this.name, this.colorValue, this.colorName);

  static List<Category> allCategory() {
    var category = List<Category>();

    category
        .add(Category("images/cosmetics.png", "全部", Colors.grey.value, "Grey"));
    category
        .add(Category("images/cosmetics.png", "收藏", Colors.red.value, "Red"));
    category.add(
        Category("images/cosmetics.png", "化妆品", Colors.pink.value, "Pink"));
    category
        .add(Category("images/digital.png", "电子产品", Colors.blue.value, "Blue"));
    category
        .add(Category("images/food.png", "食物", Colors.yellow.value, "Yellow"));
    category.add(
        Category("images/souvenir.png", "纪念品", Colors.orange.value, "Orange"));
    category.add(Category("images/toy.png", "玩具", Colors.green.value, "Green"));
    category.add(
        Category("images/clothes.png", "衣服", Colors.purple.value, "Purple"));

    return category;
  }

  Category.create(this.name, this.image, this.colorValue, this.colorName);

  Category.update(
      {@required this.id, name, image, colorCode = "", colorName = ""}) {
    if (name != "") {
      this.name = name;
    }

    if (image != "") {
      this.image = image;
    }

    if (colorCode != "") {
      this.colorValue = colorCode;
    }

    if (colorName != "") {
      this.colorName = colorName;
    }
  }

  Category.getUndefined()
      : this.update(
          id: 1,
          name: "未分类",
          image: "images/cosmetics.png",
          colorName: "Black",
          colorCode: Colors.black.value,
        );

  Category.fromMap(Map<String, dynamic> map)
      : this.update(
            id: map[dbId],
            name: map[dbName],
            image: map[dbImg],
            colorCode: map[dbColorCode],
            colorName: map[dbColorName]);
}

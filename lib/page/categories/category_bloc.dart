import 'dart:async';
import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/categories/category.dart';
import 'package:just_buy_flutter/page/categories/category_db.dart';
import 'package:just_buy_flutter/utils/color_utils.dart';


class CategoryBloc implements BlocBase {

  CategoryDB _categoryDB;

  StreamController<List<Category>> _categoryController =
   StreamController<List<Category>>.broadcast();

  Stream<List<Category>> get categories => _categoryController.stream;

  StreamController<ColorPalette> _colorController =
   StreamController<ColorPalette>.broadcast();

  Stream<ColorPalette> get colorSelection => _colorController.stream;

  CategoryBloc(this._categoryDB) {
    _loadCategory();
  }

  void _loadCategory(){
    _categoryDB.getCategories().then((categories) {
      _categoryController.sink.add(categories);
    });
  }

  void createCategory(Category category) {
    _categoryDB.insertOrReplace(category);
  }

  @override
  void dispose() {
    _categoryController.close();
    _colorController.close();
  }

}
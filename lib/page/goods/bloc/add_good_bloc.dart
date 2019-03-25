import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/goods/good_db.dart';
import 'package:just_buy_flutter/page/goods/models/good.dart';
import 'package:just_buy_flutter/page/categories/category_db.dart';
import 'package:just_buy_flutter/page/categories/category.dart';
import 'package:rxdart/rxdart.dart';

class AddGoodBloc implements BlocBase {

  final GoodDB _goodDB;
  final CategoryDB _categoryDB;

  AddGoodBloc(this._goodDB, this._categoryDB) {
    _loadCategories();
    _categorySelection.add(Category.getUndefined());
  }

  String updateGoodName = "";
  int updateGoodNum = 1;
  double updateGoodPrice;
  double updateGoodTax;
  double updateGoodDiscount;
  double updateGoodLocalRate;
  String updateGoodOwner;
  String updateGoodRemark;

  BehaviorSubject<Category> _categorySelection = BehaviorSubject<Category>();

  Stream<Category> get selectedCategory => _categorySelection.stream;

  BehaviorSubject<List<Category>> _categoryController = BehaviorSubject<List<Category>>();

  Stream<List<Category>> get categories => _categoryController.stream;

  BehaviorSubject<int> _dueDateSelected = BehaviorSubject<int>();

  Stream<int> get dueDateSelected => _dueDateSelected.stream;

  Observable<String> createGood() {
    print("123");
    return Observable.zip2(selectedCategory, dueDateSelected,
    (Category category, int dueDateSelected) {
      print("321");
      print(dueDateSelected + dueDateSelected);
      var good = Goods.create(
        name: updateGoodName,
        num: updateGoodNum,
        price: updateGoodPrice,
        tax: updateGoodTax,
        discount: updateGoodDiscount,
        localRate: updateGoodLocalRate,
        owner: updateGoodOwner,
        remark: updateGoodRemark,
        time: dueDateSelected,
        categoryId: category.id,
      );
      _goodDB.updateGood(good).then((good){
        Notification.onDone();
      });
    });
  }

  void updateDueDate(int millisecondsSinceEpoch) {
    _dueDateSelected.add(millisecondsSinceEpoch);
  }

  void _loadCategories() {
    _categoryDB.getCategories().then((categories) {
      _categoryController.add(List.unmodifiable(categories));
    });
  }

  void categorySelected(Category category) {
    _categorySelection.add(category);
  }

  @override
  void dispose() {
    _categorySelection.close();
    _dueDateSelected.close();
  }

}
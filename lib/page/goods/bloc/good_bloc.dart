import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/goods/models/good.dart';
import 'package:just_buy_flutter/page/goods/good_db.dart';
import 'dart:async';
import 'dart:collection';

class GoodBloc implements BlocBase {

  StreamController<List<Goods>> _goodController = StreamController<List<Goods>>.broadcast();

  Stream<List<Goods>> get goods => _goodController.stream;

  GoodDB _goodDb;
  List<Goods> _goodsList;

  GoodBloc(this._goodDb) {
    filterByCategory();
  }

  void _updateGoodStream(List<Goods> goods) {
    _goodsList = goods;
    _goodController.sink.add(UnmodifiableListView<Goods>(_goodsList));
  }

  void filterByCategory() {
    _goodDb.getGoods().then((goods) {
      _updateGoodStream(goods);
    });
  }

  void delete(int taskID) {
    _goodDb.deleteGood(taskID);
  }

  @override
  void dispose() {
    _goodController.close();
  }

}
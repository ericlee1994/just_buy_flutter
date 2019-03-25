import 'package:flutter/material.dart';
import 'package:just_buy_flutter/page/goods/bloc/good_bloc.dart';
import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/goods/models/good.dart';
import 'package:just_buy_flutter/page/goods/good_row.dart';

class GoodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoodBloc _goodsBloc = BlocProvider.of(context);
    return StreamBuilder<List<Goods>>(
      stream: _goodsBloc.goods,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildGoodList(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildGoodList(List<Goods> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: ObjectKey(list[index]),
                onDismissed: (DismissDirection direction) {
                  var goodID = list[index].id;
                  final GoodBloc _goodsBloc =
                      BlocProvider.of(context);
                  String message = "";
                      if (direction == DismissDirection.endToStart) {
                        _goodsBloc.delete(goodID);
                        message = "物品已删除";
                      }
                      SnackBar snackBar = SnackBar(content: Text(message));
                      Scaffold.of(context).showSnackBar(snackBar);
                },
                background: Container(
                  color: Colors.red,
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: GoodsRow(list[index]),
              );
            }),
      ),
    );
  }
}

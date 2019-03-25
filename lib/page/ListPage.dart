import 'package:flutter/material.dart';
import 'package:just_buy_flutter/page/categories/category.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:just_buy_flutter/page/goods/models/good.dart';
import 'package:just_buy_flutter/page/goods/add_good.dart';
import 'package:just_buy_flutter/page/goods/bloc/add_good_bloc.dart';
import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/goods/good_db.dart';
import 'package:just_buy_flutter/page/categories/category_db.dart';
import 'package:just_buy_flutter/page/goods/bloc/good_bloc.dart';
import 'package:just_buy_flutter/page/goods/good_listview.dart';

class ListPage extends StatelessWidget {
  final Category category;
  final GoodBloc _goodBloc = GoodBloc(GoodDB.get());
  ListPage(this.category);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Buy',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Just Buy'),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.white),
                onPressed: null),
          ],
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(child: new Calendar(isExpandable: true)),
                new Text(
                  category.name,
                ),
                new Expanded(child:
                BlocProvider(
                  bloc: _goodBloc,
                  child: GoodsPage(),
                ),)

              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async{
            var blocProviderAddGood = BlocProvider(
              bloc: AddGoodBloc(GoodDB.get(), CategoryDB.get()),
              child: AddGoodScreen(),
            );
            await Navigator.push(context,
              MaterialPageRoute(builder: (context) => blocProviderAddGood),
            );

//            _goAddPage(context, category);
            },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

void _goAddPage(BuildContext context, Category category) {
  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
    return new AddGoodScreen();
  }));
}

class MyListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
//    return new MyListViewState(Good.allGood());
  }
}

//class MyListViewState extends State<MyListView> {
//  final List<Good> allGood;
//  MyListViewState(this.allGood);
//
//  @override
//  Widget build(BuildContext context) {
//    return new ListView(
//      children: allGood.map((Good good) {
//        return _getListViewItem(good);
//      }).toList(),
//    );
//  }
//}
//
//Widget _getListViewItem(Good good) {
//  return InkWell(
//    onTap: () {},
//    child: Card(
//      color: Colors.black,
//      child: Row(
//        children: <Widget>[
//          Image.asset(
//            good.img,
//            width: 50,
//            height: 50,
//          ),
//          Column(
//            children: <Widget>[listText(good.name), listText(good.owner)],
//          ),
//          listText(good.num.toString()),
//          listText((good.num * good.price).toString()),
//        ],
//      ),
//    ),
//  );
//}

Widget listText(var name) {
  return Text(name, style: TextStyle(color: Colors.grey));
}

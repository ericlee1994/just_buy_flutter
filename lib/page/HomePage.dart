import 'package:flutter/material.dart';
import 'package:just_buy_flutter/page/categories/category.dart';
import 'package:just_buy_flutter/page/ListPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Buy',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: null),
          title: Text('Just Buy'),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: null),
          ],
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: Container(
                color: Colors.black,
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: <Widget>[
                    new Image(image: new AssetImage('images/banner.png')),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Expanded(
                          flex: 2,
                          child: Text(
                            '日本',
                            style: new TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        new Expanded(
                            child: Text(
                          '当前汇率',
                          style: new TextStyle(color: Colors.white),
                        )),
                        new Expanded(
                            child: Text(
                          '16.3585',
                          style:
                              new TextStyle(fontSize: 18, color: Colors.white),
                        ))
                      ],
                    ),
                    new Expanded(child: new MyGridView())
                  ],
                ))),
      ),
    );
  }
}

class MyGridView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new MyGridViewState(Category.allCategory());
  }
}

class MyGridViewState extends State<MyGridView> {

  final List<Category> allCategory;

  MyGridViewState(this.allCategory);


  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      crossAxisCount: 2,
      children: allCategory.map((Category category) {
        return _getGridViewItem(context, category);
      }).toList(),
    );
  }
}

Widget _getGridViewItem(BuildContext context, Category category) {
  return InkWell(
    onTap: () {
      _goListPage(context, category);
    },
    child: Card(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
//        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(category.image, fit: BoxFit.fill),
          Opacity(
            opacity: 0.7,
            child: new Container(
              width: 60,
              height: 20,
              color: Colors.white,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
              )
            ),
          )
        ],
      ),
    ),
  );
}

void _goListPage(BuildContext context, Category category) {
  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
    return new ListPage(category);
  }));
}

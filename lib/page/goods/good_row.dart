import 'package:flutter/material.dart';
import 'package:just_buy_flutter/page/goods/models/good.dart';
import 'package:just_buy_flutter/utils/date_util.dart';

class GoodsRow extends StatelessWidget {
  final Goods goods;

  GoodsRow(this.goods);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
              width: 4.0,
//                  color:
            ))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: Text(goods.name,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          getFormattedDate(goods.time),
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(goods.categoryName,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0
                                  )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                    width: 8.0,
                                    height: 8.0,
                                    child: CircleAvatar(
                                      backgroundColor: Color(goods.categoryColor),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey,

                )
              )
            ),
          )
        ],
      ),
    );
  }
}

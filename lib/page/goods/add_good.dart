import 'package:flutter/material.dart';
import 'package:just_buy_flutter/page/goods/bloc/add_good_bloc.dart';
import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/utils/date_util.dart';
import 'package:just_buy_flutter/page/categories/category.dart';

class AddGoodScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddGoodBloc createGoodBloc = BlocProvider.of(context);
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("添加物品"),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formState,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: "ipad",
                      validator: (value) {
                        var msg = value.isEmpty ? "物品名称不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodName = value;
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "物品名称"),
                    ),
                    TextFormField(
                      initialValue: "2",
                      validator: (value) {
                        var msg = value.isEmpty ? "物品数量不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodNum = int.parse(value);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "物品数量"),
                    ),
                    TextFormField(
                      initialValue: "6499",
                      validator: (value) {
                        var msg = value.isEmpty ? "物品单价不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodPrice = double.parse(value);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "物品单价"),
                    ),
                    TextFormField(
                      initialValue: "16",
                      validator: (value) {
                        var msg = value.isEmpty ? "汇率不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodLocalRate = double.parse(value);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "汇率"),
                    ),
                    TextFormField(
                      initialValue: "8",
                      validator: (value) {
                        var msg = value.isEmpty ? "消费税不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodTax = double.parse(value);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "消费税"),
                    ),
                    TextFormField(
                      initialValue: "0",
                      validator: (value) {
                        var msg = value.isEmpty ? "物品优惠不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodDiscount = double.parse(value);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "物品优惠"),
                    ),
                    TextFormField(
                      initialValue: "本人",
                      validator: (value) {
                        var msg = value.isEmpty ? "购买者不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodOwner = value;
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "购买者"),
                    ),
                    TextFormField(
                      initialValue: "无",
                      validator: (value) {
                        var msg = value.isEmpty ? "物品备注不能为空！" : null;
                        return msg;
                      },
                      onSaved: (value) {
                        createGoodBloc.updateGoodRemark = value;
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "物品备注"),
                    ),
                  ],
                )),
          ),
          ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text("购买时间"),
              subtitle: StreamBuilder(
                stream: createGoodBloc.dueDateSelected,
                initialData: DateTime.now().millisecondsSinceEpoch,
                builder: (context, snapshot) =>
                    Text(getFormattedDate(snapshot.data)),
              ),
              onTap: () {
                _selectDate(context);
              }),
          ListTile(
            leading: Icon(Icons.category),
            title: Text("分类"),
            subtitle: StreamBuilder<Category>(
                stream: createGoodBloc.selectedCategory,
                initialData: Category.getUndefined(),
                builder: (context, snapshot) => Text(snapshot.data.name),

            ),
            onTap: (){

              _showCategoryDialog(createGoodBloc, context);}
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send, color: Colors.white),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              createGoodBloc.createGood().listen((value) {
                Navigator.pop(context, true);
              });
            }
          }),
    );
  }

  Future _showCategoryDialog(
      AddGoodBloc createGoodBloc, BuildContext context) async {
    return showDialog(context: context, builder:
    (BuildContext dialogContext) {
      return StreamBuilder(
        stream: createGoodBloc.categories,
        initialData: List<Category>(),
        builder: (context, snapshot) {
          return SimpleDialog(
            title: const Text('选择分类'),
            children: buildCategories(createGoodBloc, context, snapshot.data),
          );
        },
      );
    });
  }

  List<Widget> buildCategories(AddGoodBloc createGoodBloc, BuildContext context, List<Category> categoryList) {
    List<Widget> categories = List();
    categoryList.forEach((category) {
      categories.add(ListTile(
        leading: Container(
          width: 12.0,
          height: 12.0,
          child: CircleAvatar(
            backgroundColor: Color(category.colorValue),
          ),
        ),
        title: Text(category.name),
        onTap: () {
          createGoodBloc.categorySelected(category);
          Navigator.pop(context);
        },
      ));
    });
    return categories;
  }


  Future<Null> _selectDate(BuildContext context) async {
    AddGoodBloc createGoodBloc = BlocProvider.of(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2100));
    if (picked != null) {
      createGoodBloc.updateDueDate(picked.millisecondsSinceEpoch);
    }
  }
}

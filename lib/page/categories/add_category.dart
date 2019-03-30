import 'package:flutter/material.dart';
import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/categories/category.dart';
import 'package:just_buy_flutter/page/categories/category_bloc.dart';
import 'package:just_buy_flutter/utils/collapsable_expand_tile.dart';
import 'package:just_buy_flutter/utils/color_utils.dart';

class AddCategory extends StatelessWidget {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final expansionTile = GlobalKey<CollapsibleExpansionTileState>();

  @override
  Widget build(BuildContext context) {
    CategoryBloc _categoryBloc = BlocProvider.of(context);
    ColorPalette colorPalette;
    String categoryName = "";
    return Scaffold(
      appBar: AppBar(
        title: Text("添加分类"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              var category = Category.create(categoryName, "",
                  colorPalette.colorValue, colorPalette.colorName);
              _categoryBloc.createCategory(category);
              Navigator.pop(context, true);
            }
          }),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "分类名称"),
                maxLength: 20,
                validator: (value) {
                  return value.isEmpty ? "分类名称不能为空" : null;
                },
                onSaved: (value) {
                  categoryName = value;
                },
              ),
            ),
            key: _formState,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: StreamBuilder(
              stream: _categoryBloc.colorSelection,
              initialData: ColorPalette("Grey", Colors.grey.value),
              builder: (context, snapshot) {
                colorPalette = snapshot.data;
                return CollapsibleExpansionTile(
                  key: expansionTile,
                  leading: Container(
                    width: 12.0,
                    height: 12.0,
                    child: CircleAvatar(
                      backgroundColor: Color(snapshot.data.colorValue),
                    ),
                  ),
                  title: Text(snapshot.data.colorName),
                  children: buildMaterialColors(_categoryBloc),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildMaterialColors(CategoryBloc categoryBloc) {
    List<Widget> projectWidgetList = List();
    colorsPalettes.forEach((colors) {
      projectWidgetList.add(ListTile(
        leading: Container(
          width: 12.0,
          height: 12.0,
          child: CircleAvatar(
            backgroundColor: Color(colors.colorValue),
          ),
        ),
        title: Text(colors.colorName),
        onTap: () {
          expansionTile.currentState.collapse();
          categoryBloc.updateColorSelection(
            ColorPalette(colors.colorName, colors.colorValue),
          );
        },
      ));
    });
    return projectWidgetList;
  }
}

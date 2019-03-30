import 'package:flutter/material.dart';
import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/categories/add_category.dart';
import 'package:just_buy_flutter/page/categories/category.dart';
import 'package:just_buy_flutter/page/categories/category_bloc.dart';
import 'package:just_buy_flutter/page/categories/category_db.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryBloc categoryBloc = BlocProvider.of<CategoryBloc>(context);
    return StreamBuilder<List<Category>>(
      stream: categoryBloc.categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CategoryExpansionTileWidget(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class CategoryExpansionTileWidget extends StatelessWidget {
  final List<Category> _categorys;

  CategoryExpansionTileWidget(this._categorys);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.book),
      title: Text("Category",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildCategories(context),
    );
  }

  List<Widget> buildCategories(BuildContext context) {
    List<Widget> categoryWidgetList = List();
    _categorys.forEach((project) => categoryWidgetList.add(CategoryRow(project)));
    categoryWidgetList.add(ListTile(
      leading: Icon(Icons.add),
      title: Text("Add Category"),
      onTap: () async {
        Navigator.pop(context);
        CategoryBloc categoryBloc = BlocProvider.of<CategoryBloc>(context);
        Widget addProject = BlocProvider(
          bloc: CategoryBloc(CategoryDB.get()),
          child: AddCategory(),
        );
        await Navigator.push(
            context,
            MaterialPageRoute<bool>(
              builder: (context) => addProject,
            ));
        categoryBloc.refresh();
      },
    ));
    return categoryWidgetList;
  }
}

class CategoryRow extends StatelessWidget {
  final Category category;

  CategoryRow(this.category);

  @override
  Widget build(BuildContext context) {
//    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      onTap: () {
//        homeBloc.applyFilter(category.name, Filter.byProject(project.id));
//        Navigator.pop(context);
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      title: Text(category.name),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: CircleAvatar(
          backgroundColor: Color(category.colorValue),
        ),
      ),
    );
  }
}
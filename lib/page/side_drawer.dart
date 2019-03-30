import 'package:flutter/material.dart';
import 'package:just_buy_flutter/bloc/bloc_provider.dart';
import 'package:just_buy_flutter/page/categories/category_bloc.dart';
import 'package:just_buy_flutter/page/categories/category_db.dart';
import 'package:just_buy_flutter/page/category_widget.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Eric"),
            accountEmail: Text("843251949eric@gmail.com"),
//            otherAccountsPictures: <Widget>[
//              IconButton(
//                  icon: Icon(
//                    Icons.info,
//                    color: Colors.white,
//                    size: 36.0,
//                  ),
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute<bool>(
//                          builder: (context) => AboutUsScreen()),
//                    );
//                  })
//            ],
//            currentAccountPicture: CircleAvatar(
//              backgroundColor: Theme.of(context).accentColor,
//              backgroundImage: AssetImage("assets/profile_pic.jpg"),
//            ),
          ),
//          ListTile(
//              leading: Icon(Icons.inbox),
//              title: Text("Inbox"),
//              onTap: () {
//                var project = Project.getInbox();
//                homeBloc.applyFilter(
//                    project.name, Filter.byProject(project.id));
//                Navigator.pop(context);
//              }),
//          ListTile(
//              onTap: () {
//                homeBloc.applyFilter("Today", Filter.byToday());
//                Navigator.pop(context);
//              },
//              leading: Icon(Icons.calendar_today),
//              title: Text("Today")),
//          ListTile(
//            onTap: () {
//              homeBloc.applyFilter("Next 7 Days", Filter.byNextWeek());
//              Navigator.pop(context);
//            },
//            leading: Icon(Icons.calendar_today),
//            title: Text("Next 7 Days"),
//          ),
//          BlocProvider(
//            bloc: ProjectBloc(ProjectDB.get()),
//            child: ProjectPage(),
//          ),
          BlocProvider(child: CategoryPage(),
              bloc: CategoryBloc(CategoryDB.get())
          ),
//          BlocProvider(
//            bloc: LabelBloc(LabelDB.get()),
//            child: LabelPage(),
//          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ss_marker_flutter/src/bloc/user_bloc/user_bloc.dart';
import 'package:ss_marker_flutter/src/config/route.dart' as custom_route;
import 'package:ss_marker_flutter/src/config/theme.dart' as custom_theme;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ss_marker_flutter/src/constants/setting.dart';
import 'package:ss_marker_flutter/src/models/user_model.dart';
import 'package:ss_marker_flutter/src/pages/home/widgets/custom_drawer.dart';
import 'package:ss_marker_flutter/src/pages/home/widgets/custom_tab_bar.dart';
import 'package:ss_marker_flutter/src/view-models/tab_menu_view_model.dart';

import '../note/note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabsMenu = TabMenuViewModel().items;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabsMenu.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Marker'),
          bottom: CustomTabBar(_tabsMenu),
        ),
        drawer: const CustomDrawer(),
        body: TabBarView(
          children: _tabsMenu.map((item) => item.widget).toList(),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     print(DefaultTabController.of(context)?.length);
        //   },
        //   tooltip: 'Add',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }

  void _logout() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(Setting.token);
      Navigator.pushReplacementNamed(context, '/');
    });
  }
}

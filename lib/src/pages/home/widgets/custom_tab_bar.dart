import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ss_marker_flutter/src/view-models/tab_menu_view_model.dart';



class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TabMenu> tabsMenu;
  const CustomTabBar(this.tabsMenu, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TabBar(tabs: tabsMenu.map((item) => Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(item.icon),
          const SizedBox(
            width: 12,
          ),
          Text(
            item.title,
            style:
            const TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    )).toList());
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

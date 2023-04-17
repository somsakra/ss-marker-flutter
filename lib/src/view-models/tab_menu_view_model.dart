import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ss_marker_flutter/src/pages/edit/add_page.dart';
import 'package:ss_marker_flutter/src/pages/note/note_page.dart';



class TabMenu {
  final String title;
  final IconData icon;
  final Widget widget;

  const TabMenu(this.title, this.widget, {required this.icon});
}

class TabMenuViewModel {
  List<TabMenu> get items => <TabMenu>[
    const TabMenu('Read', NotePage(), icon: FontAwesomeIcons.noteSticky),
    const TabMenu('Add', AddPage(), icon: FontAwesomeIcons.marker),
  ];
}
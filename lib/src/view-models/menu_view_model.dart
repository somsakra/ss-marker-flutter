import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ss_marker_flutter/src/config/route.dart' as custom_route;
import 'package:ss_marker_flutter/src/config/theme.dart' as custom_theme;

class Menu {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Function(BuildContext context)? onTap;

  const Menu(this.title, {this.icon, this.iconColor, this.onTap});
}

class MenuViewModel {
  List<Menu> get items => <Menu>[
    // Menu(
    //   'Profile',
    //   icon: FontAwesomeIcons.user,
    //   iconColor: custom_theme.Theme.primaryColorDark,
    //   onTap: (context) {},
    // ),
    Menu(
      'Note',
      icon: FontAwesomeIcons.noteSticky,
      iconColor: custom_theme.Theme.primaryColorDark,
      onTap: (context) {
        Navigator.pop(context);
      },
    ),
  ];
}
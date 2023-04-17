import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ss_marker_flutter/src/bloc/user_bloc/user_bloc.dart';
import 'package:ss_marker_flutter/src/config/route.dart' as custom_route;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ss_marker_flutter/src/constants/asset.dart';
import 'package:ss_marker_flutter/src/constants/setting.dart';
import 'package:ss_marker_flutter/src/models/user_model.dart';
import 'package:ss_marker_flutter/src/view-models/menu_view_model.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    context.read<UserBloc>().add(UserEventInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          User user = state.user;
          return Column(
            children: [
              _buildProfile(user: user),
              ..._buildMainMenu(), //spread operator
              const Spacer(),
              SafeArea(
                child: ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.rightFromBracket,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Logout',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                  ),
                  onTap: showDialogLogout,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  UserAccountsDrawerHeader _buildProfile({required User user}) {
    String emailMd5 = md5.convert(utf8.encode(user.email)).toString();
    return UserAccountsDrawerHeader(
      accountName: Text(user.email.split('@')[0]),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage:
            NetworkImage('https://www.gravatar.com/avatar/$emailMd5'),
      ),
    );
  }

  void showDialogLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: const Text('Logout ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent, // Text Color
              ),
              child: const Text('Logout'),
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove(Setting.token);
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  Navigator.pushNamedAndRemoveUntil(
                      context, custom_route.Route.login, (route) => false);
                });
              },
            ),
          ],
        );
      },
    );
  }

  List<ListTile> _buildMainMenu() => MenuViewModel()
      .items
      .map(
        (item) => ListTile(
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          leading: Badge(
            showBadge: false,
            child: FaIcon(item.icon, color: item.iconColor),
          ),
          onTap: () => item.onTap!(context),
        ),
      )
      .toList();
}

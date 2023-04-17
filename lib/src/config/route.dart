import 'package:flutter/material.dart';
import 'package:ss_marker_flutter/src/pages/edit/add_page.dart';
import 'package:ss_marker_flutter/src/pages/note/note_page.dart';
import 'package:ss_marker_flutter/src/pages/pages.dart';

import 'package:ss_marker_flutter/src/pages/register/signup_page.dart';


class Route {
  static const home = '/home';
  static const login = '/login';
  static const signup = '/signup';
  static const note = '/note';
  static const edit = '/edit';


  static Map<String, WidgetBuilder> getRoute() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    signup: (context) => const SignupPage(),
    note: (context) => const NotePage(),
    edit: (context) => const AddPage()
  };
}

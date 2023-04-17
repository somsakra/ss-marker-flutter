import 'package:flutter/material.dart';
import 'package:ss_marker_flutter/src/config/route.dart' as custom_route;
import 'package:ss_marker_flutter/src/config/theme.dart' as custom_theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ss_marker_flutter/src/bloc/note_bloc/note_bloc.dart';
import 'package:ss_marker_flutter/src/bloc/user_bloc/user_bloc.dart';
import 'package:ss_marker_flutter/src/constants/setting.dart';
import 'package:ss_marker_flutter/src/pages/home/home_page.dart';
import 'package:ss_marker_flutter/src/pages/login/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider<UserBloc>(create: (context) => UserBloc());
    final noteBloc = BlocProvider<NoteBloc>(create: (context) => NoteBloc());

    return MultiBlocProvider(
      providers: [userBloc, noteBloc],
      child: MaterialApp(
        routes: custom_route.Route.getRoute(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final token = snapshot.data?.getString(Setting.token) ?? '';
              if (token.isNotEmpty) {
                return const HomePage();
              }
              return const LoginPage();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

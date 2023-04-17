import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ss_marker_flutter/src/constants/setting.dart';
import 'package:ss_marker_flutter/src/models/credential_model.dart';
import 'package:ss_marker_flutter/src/models/user_model.dart';
import 'package:ss_marker_flutter/src/services/network_services.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(user: User())) {
    on<UserEventLogin>((event, emit) async {
      final result = await NetworkService().userLogin(event.credential);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Setting.token, result['token']);
      prefs.setString(Setting.email, result['email']);

      User userState = User(
          message: result['message'],
          email: result['email'],
          token: result['token']);

      emit(state.copyWith(user: userState));
    });

    on<UserEventInitial>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String email = prefs.getString('email') ?? "";
      User userState = User(email: email);
      emit(state.copyWith(user: userState));
    });
  }
}

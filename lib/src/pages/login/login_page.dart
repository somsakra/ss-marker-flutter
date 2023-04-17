import 'package:flutter/material.dart';
import 'package:ss_marker_flutter/src/config/route.dart' as custom_route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ss_marker_flutter/src/config/theme.dart' as custom_theme;
import 'package:ss_marker_flutter/src/models/credential_model.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey();
  late Credential _credential;

  @override
  void initState() {
    _credential = Credential(email: "", password: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration:
                    const BoxDecoration(gradient: custom_theme.Theme.gradient),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    const Icon(
                      FontAwesomeIcons.marker,
                      color: custom_theme.Theme.primaryColorWhite,
                      size: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Welcome to Marker',
                      style: TextStyle(
                          color: custom_theme.Theme.primaryColorWhite,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _form,
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(
                            bottom: 22, left: 22, right: 22),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          children: [
                            buildTextInput(
                                label: 'E-mail',
                                onSaved: (String? value) {
                                  _credential.email =
                                      value!.isEmpty ? "" : value;
                                }),
                            buildTextInput(
                                obscureText: true,
                                label: 'Password',
                                onSaved: (String? value) {
                                  _credential.password =
                                      value!.isEmpty ? "" : value;
                                }),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 20, right: 20),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: custom_theme
                                              .Theme.primaryColorLight,
                                          width: 4)),
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () async {
                                        _form.currentState?.save();
                                        context.read<UserBloc>().add(
                                            UserEventLogin(
                                                credential: _credential));
                                        Future.delayed(
                                                const Duration(seconds: 1))
                                            .then((value) => {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/')
                                                });
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: custom_theme
                                            .Theme.primaryColorLight,
                                        padding: const EdgeInsets.all(12.0),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: const Text('Login'))),
                            )
                          ],
                        ),
                      ),
                    ),
                    _buildTextButton('Forgot Password', onPressed: () {}),
                    _buildTextButton("Don't have account",
                        onPressed: () => Navigator.pushNamed(
                            context, custom_route.Route.signup)),
                    const SizedBox(height: 80)
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Padding buildTextInput(
      {required String label,
      required void Function(String?)? onSaved,
      bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        onSaved: onSaved,
        style: const TextStyle(
            color: custom_theme.Theme.primaryColorDark,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: custom_theme.Theme.primaryColorLight)),
            labelText: label,
            labelStyle:
                (const TextStyle(color: custom_theme.Theme.primaryColorLight))),
        obscureText: obscureText,
      ),
    );
  }

  TextButton _buildTextButton(String text,
      {required VoidCallback onPressed, double fontSize = 20}) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: custom_theme.Theme.primaryColorWhite, fontSize: fontSize),
        ));
  }
}

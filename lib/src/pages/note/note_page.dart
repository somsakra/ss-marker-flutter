import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ss_marker_flutter/src/bloc/note_bloc/note_bloc.dart';
import 'package:ss_marker_flutter/src/config/theme.dart' as custom_theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ss_marker_flutter/src/models/note_model.dart';
import 'package:ss_marker_flutter/src/services/network_services.dart';

import '../../models/user_model.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    context.read<NoteBloc>().add(NoteEventGetAllNote());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          List<NoteElement> notes = state.note.notes;
          return RefreshIndicator(
              onRefresh: () async {
                context.read<NoteBloc>().add(NoteEventGetAllNote());
              },
              child: SingleChildScrollView(
                child: Column(children: [
                  ...notes.map((note) => _buildNote(
                      id: note.id, title: note.title, content: note.content)),
                  const SizedBox(height: 150),
                ]),
              ));
        },
      ),
    );
  }

  Center _buildNote(
      {required String id, required String title, required String content}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          color: custom_theme.Theme.primaryColorWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: custom_theme.Theme.primaryColorDark,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, bottom: 10, top: 10),
                child: Text(
                  content,
                  style: const TextStyle(
                      color: custom_theme.Theme.primaryColorDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 32,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => context
                            .read<NoteBloc>()
                            .add(NoteEventDeleteNote(id: id)),
                        child: const FaIcon(
                          FontAwesomeIcons.trash,
                          color: custom_theme.Theme.primaryColorDark,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

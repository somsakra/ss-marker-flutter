import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ss_marker_flutter/src/bloc/note_bloc/note_bloc.dart';
import 'package:ss_marker_flutter/src/bloc/user_bloc/user_bloc.dart';
import 'package:ss_marker_flutter/src/config/theme.dart' as custom_theme;
import 'package:ss_marker_flutter/src/models/note_content_model.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _form = GlobalKey();
  late NoteContent _noteContent;

  @override
  void initState() {
    _noteContent = NoteContent(title: "", content: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _form,
                child: Card(
                  color: custom_theme.Theme.primaryColorWhite,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onSaved: (String? value){
                              _noteContent.title = value!.isEmpty ? " " : value;
                            },
                              style: const TextStyle(
                                  color: custom_theme.Theme.primaryColorDark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  hintText: 'Title',
                                  hintStyle: (TextStyle(
                                      color: custom_theme.Theme
                                          .primaryColorLight)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              onSaved: (String? value){
                                _noteContent.content = value!.isEmpty ? " " : value;
                              },
                              minLines: 1,
                              maxLines: 5,
                              style: const TextStyle(
                                  color: custom_theme.Theme.primaryColorDark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  hintText: 'Content',
                                  hintStyle: (TextStyle(
                                      color: custom_theme.Theme
                                          .primaryColorLight)))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _form.currentState?.save();
          context.read<NoteBloc>().add(NoteEventAddNewNote(noteContent: _noteContent));
          Navigator.pushReplacementNamed(context, "/");
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

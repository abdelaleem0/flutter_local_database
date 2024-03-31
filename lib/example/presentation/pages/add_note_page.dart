import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_database/example/data/mappers/notes_extension.dart';
import 'package:flutter_local_database/example/domain/entities/note_entity.dart';
import 'package:flutter_local_database/example/presentation/manager/notes_cubit.dart';
import 'package:flutter_local_database/example/presentation/manager/notes_state.dart';
import 'package:flutter_local_database/example/presentation/utils/toast.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ValueNotifier<ColorEnum> _dropdownValue =ValueNotifier(ColorEnum.white);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: BlocListener<NotesCubit, NotesState>(
          listenWhen: (previous, current) =>
              previous.insertNote != current.insertNote,
          listener: (context, state) {
            if (state.insertNote.isSuccess) {
              Navigator.of(context).pop();
            }
            if (state.insertNote.isFailure) {
              ToastManger.showToast(state.insertNote.errorMessage ?? '');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    title: "Title",
                    controller: _titleController,
                  ),
                  AppTextField(
                    title: "description",
                    controller: _descriptionController,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Color ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        width: 200,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _dropdownValue,
                        builder: (context, value, child) =>
                            DropdownButton<ColorEnum>(
                          value: _dropdownValue.value,
                          items: ColorEnum.values.map((e) {
                            return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.name,
                                  style: TextStyle(color: e.getColor),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _dropdownValue.value = value;
                            }
                          },
                        ),),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MaterialButton(
                    color: const Color(0xffefb7ff),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _insertItem();
                      }
                    },
                    child: const Text(
                      "add note",
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _insertItem() async {
    BlocProvider.of<NotesCubit>(context).insertNote(NoteEntity(
        id: Random().nextInt(1000000000),
        title: _titleController.text,
        description: _descriptionController.text,
        color: _dropdownValue.value));
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final void Function(String)? onChanged;

  const AppTextField(
      {super.key,
      required this.controller,
      required this.title,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'text is Empty';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

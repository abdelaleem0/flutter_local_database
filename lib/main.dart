import 'package:flutter/material.dart';
import 'package:flutter_local_database/note_app/data/di/notes_di.dart';
import 'package:flutter_local_database/note_app/presentation/pages/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(
    const MyApp(),
  );
}

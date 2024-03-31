import 'package:flutter/material.dart';
import 'package:flutter_local_database/example/data/di/notes_di.dart';
import 'package:flutter_local_database/example/presentation/pages/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(
    const MyApp(),
  );
}

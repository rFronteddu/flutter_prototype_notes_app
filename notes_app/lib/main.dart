import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'model/note_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = NoteDatabase.instance;
  await db.readAllNotes();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteDatabase>.value(value: db),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().themeData,
      home: NotesPage(),
    );
  }
}

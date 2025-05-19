import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer.dart';
import 'package:notes_app/components/note_tile.dart';
import 'package:notes_app/model/note_database.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNote();
  }

  // create note
  void createNote() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                onPressed: () async {
                  final noteDb = context.read<NoteDatabase>();
                  final navigator = Navigator.of(context);

                  await noteDb.create(textController.text);
                  textController.clear();
                  await noteDb.readAllNotes(); // refresh the notes list

                  if (!mounted) return;
                  navigator.pop();
                },
                child: const Text("Create"),
              ),
            ],
          ),
    );
  }

  // read note
  void readNote() {
    context.read<NoteDatabase>().readAllNotes();
  }

  // update node
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text("Update"),
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);

                  await context.read<NoteDatabase>().update(
                    note.id!,
                    textController.text,
                  );
                  textController.clear();
                  navigator.pop();
                },
                child: const Text("Update"),
              ),
            ],
          ),
    );
  }

  // delete node
  void deleteNote(int id) async {
    // 3:34:55
    final noteDb = context.read<NoteDatabase>();
    await noteDb.delete(id);
    await noteDb.readAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteDb = context.watch<NoteDatabase>();
    List<Note> currNotes = noteDb.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: MyDrawer(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // LIST of notes
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final note = currNotes[index];
                return NoteTile(
                  text: note.text,
                  onEditTap: () => updateNote(note),
                  onDeleteTap: () => deleteNote(note.id!),
                );
              },
              itemCount: currNotes.length,
            ),
          ),
        ],
      ),
    );
  }
}

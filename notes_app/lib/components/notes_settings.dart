import 'package:flutter/material.dart';

class NotesSettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const NotesSettings({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // edit
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              onEditTap!();
            },
            child: Container(
              height: 50,
              color: Theme.of(context).colorScheme.surface,
              child: Text(
                "Edit",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // delete
          GestureDetector(
            onTap:  () {
              Navigator.pop(context);
              onDeleteTap!();
            },
            child: Container(
              height: 50,
              color: Theme.of(context).colorScheme.surface,
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

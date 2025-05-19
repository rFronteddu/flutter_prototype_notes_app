import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'notes_settings.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;

  const NoteTile({
    super.key,
    required this.text,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(bottom: 10, left: 25, right: 25),

      child: ListTile(
        title: Text(text),
        trailing: Builder(
          builder:
              (context) => IconButton(
                onPressed:
                    () => showPopover(
                      width: 100,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      context: context,
                      bodyBuilder:
                          (context) => NotesSettings(
                            onEditTap: onEditTap,
                            onDeleteTap: onDeleteTap,
                          ),
                    ),
                icon: const Icon(Icons.more_vert),
              ),
        ),
      ),
    );
  }
}

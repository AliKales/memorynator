import 'package:flutter/material.dart';
import 'package:memorynator/core/models/m_note.dart';
import 'package:memorynator/widgets/note/note_widget.dart';

class Notes extends StatelessWidget {
  const Notes({
    super.key,
    required this.notes,
    required this.onDelete,
    required this.onTap,
  });

  final List<MNote> notes;
  final ValueChanged<int> onDelete;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: List.generate(
        notes.length,
        (index) => NoteWidget(
          index: index,
          note: notes[index],
          onDelete: () => onDelete.call(index),
          onTap: () => onTap.call(index),
        ),
      ),
    );
  }
}

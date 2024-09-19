import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/note_details.dart';

final formatter = DateFormat('EEE dd, y');

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NoteDetails(
              note: note,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: note.color,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Text(
                note.description.replaceAll('[', '').replaceAll(']', ''),
                overflow: TextOverflow.fade,
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                formatter.format(note.date),
                style: const TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

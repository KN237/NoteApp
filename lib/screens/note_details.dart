import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/add_note.dart';

final formatter = DateFormat('EEE dd, y');

class NoteDetails extends StatelessWidget {
  const NoteDetails({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(139, 21, 21, 21),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 18,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => AddNote(
                    note: note,
                  ),
                ),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(139, 21, 21, 21),
              ),
              child: const Icon(
                Icons.edit,
                size: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                formatter.format(note.date),
                style:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                note.description.replaceAll('[', '').replaceAll(']', ''),
                textAlign: TextAlign.justify,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}

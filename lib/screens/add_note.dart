import 'package:flutter/material.dart';
import 'package:note_app/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/note_providers.dart';
import 'package:note_app/models/note.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, this.note});
  final Note? note;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void save() {
    bool isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      try {
        if (widget.note == null) {
          context.read<NoteProviders>().addNote(Note(
                title: titleController.text,
                description: descriptionController.text,
                date: DateTime.now(),
              ));
        } else {
          context.read<NoteProviders>().updateNote(widget.note!.id,
              titleController.text, descriptionController.text);
        }
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const HomePage(),
          ),
        );
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Success'),
          ),
        );
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error $e'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descriptionController.text = widget.note!.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: titleController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please fill this fiels';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  titleController.text = newValue!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 8,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    hintText: 'Type someting...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    )),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please fill this fiels';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  descriptionController.text = newValue!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: save,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 59, 59, 59),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/note_providers.dart';
import 'package:note_app/screens/note_details.dart';
import 'package:provider/provider.dart';

final formatter = DateFormat('EEE dd, y');

class NoteItem extends StatefulWidget {
  const NoteItem({super.key, required this.note});
  final Note note;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation =
        Tween<double>(begin: 1, end: 0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NoteDetails(
              note: widget.note,
            ),
          ),
        );
      },
      onLongPress: () async {
        _animationController.forward();
        Future.delayed(const Duration(seconds: 1), () {
          context.read<NoteProviders>().removeNote(widget.note);
        });
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: widget.note.color,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Text(
                  widget.note.description
                      .replaceAll('[', '')
                      .replaceAll(']', ''),
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
                  formatter.format(widget.note.date),
                  style: const TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

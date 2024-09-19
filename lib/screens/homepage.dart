import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/providers/note_providers.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/widgets/note_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    _animationController.forward();
    context.read<NoteProviders>().loadData();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('NOTEONE'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: context.watch<NoteProviders>().isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              )
            : context.watch<NoteProviders>().lenght <= 0
                ? const Center(
                    child: Text('No Data'),
                  )
                : MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: context.watch<NoteProviders>().lenght,
                    itemBuilder: (ctx, index) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: NoteItem(
                            note:
                                context.watch<NoteProviders>().noteList[index]),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddNote(),
            ),
          );
        },
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(221, 59, 59, 59),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

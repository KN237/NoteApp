import 'package:flutter/material.dart';
import 'package:note_app/providers/note_providers.dart';
import 'package:note_app/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (ctx) => NoteProviders(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NoteOne',
            theme: ThemeData.dark().copyWith(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: const Color.fromARGB(221, 59, 59, 59),
                appBarTheme: const AppBarTheme(
                  color: Color.fromARGB(221, 59, 59, 59),
                )),
            home: const HomePage(),
          );
        }),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_notes_app/screens/note_detail.dart';
import 'package:flutter_notes_app/screens/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
    @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple
        ),
        home: NoteList(),
      );
  }
}
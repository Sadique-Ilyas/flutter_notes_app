import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_notes_app/models/note.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper; // Singleton Database Helper
  static Database _database;             // Singleton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper.createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper.createInstance(); // This is executed only oce, singleton object
    }
    return _databaseHelper;
  }


  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    // Get the directory path for both Android and iOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    //  Open/Create the database at the given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  // Create database
  void _createDb(Database db, int newVersion) async{
    await db.execute("CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,"
                     "$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }

  // Insert Operation
  Future<int> insertNote(Note note) async{
    Database db = await this.database;
    var result = db.insert(noteTable, note.toMap());
    return result;
  }

  // Fetch Operation
  Future<List<Map<String, dynamic>>> getNoteMapList() async{
    Database db = await this.database;

  //var result = await db.rawQuery('SELECT * FROM $noteTable ORDER BY $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Update Operation
  Future<int> updateNote(Note note) async{
    var db = await this.database;
    var result = db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation
  deleteNote(int id) async{
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  // Get the number of objects (entries) in database
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async{
    var noteMapList = await getNoteMapList();    // Get the 'Map List' from database
    int count = noteMapList.length;              // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
     // For loop to create a 'Note List' from a 'Map List'
     for(int i = 0; i < count; i++){
       noteList.add(Note.fromMapObject(noteMapList[i]));
     }
     return noteList;
  }
}
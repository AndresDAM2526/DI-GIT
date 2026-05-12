import 'package:examen_2_evaluacion/model/libro_formulario_model.dart';
import 'package:examen_2_evaluacion/model/libro_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseService extends ChangeNotifier {
  late final Future<Database> database;
  List<Map<String, dynamic>> _generos = [];
  List<Map<String, dynamic>> _libros = [];

  List<Map<String, dynamic>> get generos => _generos;
  List<Map<String, dynamic>> get libros => _libros;

  DatabaseService() {
    database = _cargarBBDD();
    cargarGeneros();
    cargarLibros();
  }

  Future<Database> _cargarBBDD() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final dbPath = join(
      await databaseFactory.getDatabasesPath(),
      'libreria.db',
    );
    final database = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE IF NOT EXISTS genres(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT UNIQUE
          )''');

          await db.execute('''CREATE TABLE IF NOT EXISTS books(
                                id INTEGER PRIMARY KEY AUTOINCREMENT,
                                title TEXT,
                                author TEXT,
                                id_genre INTEGER,
                                state TEXT,
                                date TEXT,
                                FOREIGN KEY(id_genre) references genres(id) ON DELETE CASCADE ON UPDATE CASCADE
          )''');
          await db.insert('genres', {'name': 'Novela'});
          await db.insert('genres', {'name': 'Ensayo'});
          await db.insert('genres', {'name': 'Ciencia'});
          await db.insert('genres', {'name': 'Fantasia'});
        },
      ),
    );
    return database;
  }

  Future<void> cargarLibros() async {
    final db = await database;
    _libros = await db.query('books');
    notifyListeners();
  }

  Future<List<String>> cargarGeneros() async {
    final db = await database;
    _generos = await db.query('genres', columns: ['name']);
    notifyListeners();
    return _generos.map((genero) => genero['name'].toString()).toList();
  }

  Future<void> borrarLibro(int id) async {
    final db = await database;
    await db.delete('books', where: 'id=?', whereArgs: [id]);
    cargarLibros();
    notifyListeners();
  }

  Future<void> insertarLibro(LibroFormularioModel libro) async {
    final db = await database;
    //int idgenero = await obtenerIdGenero(libro.genero);
    await db.insert('books', {
      'title': libro.titulo,
      'author': libro.autor,
      'id_genre': libro.genero,
      'state': libro.estado,
      'date': DateTime.now().toIso8601String(),
    });
    cargarLibros();
    notifyListeners();
  }

  Future<int> obtenerIdGenero(String categoria) async {
    final db = await database;
    final List<Map<String, dynamic>> resultado = await db.query(
      'genres',
      columns: ['id'],
      where: 'name=?',
      whereArgs: [categoria],
    );
    return resultado.first['name'];
  }
}

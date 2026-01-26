import 'package:ejercicio_repaso/model/usuario_formulario_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseViewmodel extends ChangeNotifier {
  late final Future<Database> database;

  DatabaseViewmodel() {
    database=_cargarBaseDatos();
  }

  Future<Database> _cargarBaseDatos() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final dbPath = join(await databaseFactory.getDatabasesPath(), 'gastos.db');
    final database = await databaseFactory.openDatabase(dbPath);
    await database.execute('''CREATE TABLE IF NOT EXISTS Usuario(
      id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      direccion TEXT,
      fecha_nacimiento TEXT
    )''');

    await database.execute(''' CREATE TABLE IF NOT EXISTS Cuenta(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo TEXT,
    categoria TEXT,
    dinero REAL
  )''');
    return database;
  }

  Future<void> anadirUsuario(UsuarioFormularioModel usuario) async {
    final db = await database;
    await db.insert('Usuario', {
      'nombre': usuario.nombre,
      'direccion': usuario.direccion,
      'fecha_nacimiento': usuario.fechaNacimiento,
    });
    notifyListeners();
  }
}

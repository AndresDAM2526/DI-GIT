import 'package:flutter/widgets.dart';
import 'package:prueba_examen/model/transaccion_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseViewmodel extends ChangeNotifier {
  late final Future<Database> database;
  List<Map<String, dynamic>> _transacciones = [];
  List<Map<String, dynamic>> get transacciones => _transacciones;

  DatabaseViewmodel() {
    database = _cargarBBDD();
    obtenerTransacciones();
  }

  Future<Database> _cargarBBDD() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final dbPath = join(
      await databaseFactory.getDatabasesPath(),
      'conversiones.db',
    );
    final database = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE IF NOT EXISTS conversion(
                                id_conversion INTEGER PRIMARY KEY AUTOINCREMENT,
                                valor_inicial REAL NOT NULL,
                                unidad_inicial TEXT NOT NULL,
                                unidad_final TEXT NOT NULL,
                                valor_final REAL NOT NULL
          )''');
        },
      ),
    );
    return database;
  }

  Future<void> guardarTransaccion(TransaccionModel transaccion) async {
    final db = await database;
    await db.insert('conversion', {
      'valor_inicial': transaccion.valorInicial,
      'unidad_inicial': transaccion.unidadInicial,
      'unidad_final': transaccion.unidadFinal,
      'valor_final': transaccion.valorFinal,
    });
    obtenerTransacciones();
    notifyListeners();
  }

  Future<void> obtenerTransacciones() async {
    final db = await database;
    _transacciones = await db.query('conversion');
    notifyListeners();
  }

  Future<void> borrarTransaccion(int idTransaccion) async {
    final db = await database;
    await db.delete(
      'conversion',
      where: 'id_conversion=?',
      whereArgs: [idTransaccion],
    );
    obtenerTransacciones();
    notifyListeners();
  }
}

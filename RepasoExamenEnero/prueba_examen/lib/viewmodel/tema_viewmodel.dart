import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Clase que realiza operaciones relacionadas con el tema de la aplicacion
class TemaViewmodel extends ChangeNotifier {
  bool _modoOscuro = false;

  double _tamanio = 15;

  String _idioma = "Español";

  ///Variable que controla el modo oscuro
  bool get modoOscuro => _modoOscuro;

  ///Variable que controla el tamaño del texto
  double get tamanio => _tamanio;

  ///Variable que controla el idioma de la aplicacion
  String get idioma => _idioma;

  ThemeMode get tema => _modoOscuro == true ? ThemeMode.dark : ThemeMode.light;

  ///Constructor
  TemaViewmodel() {
    cargarDatos();
  }

  ///Función que cargar los datos guardados en las SharedPreferences
  Future<void> cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
    _tamanio = prefs.getDouble('tamanio') ?? 15;
    _idioma = prefs.getString("idioma") ?? "Español";
    notifyListeners();
  }


  ///Función que cambia el **[Modo oscuro]** y guarda el dato en las SharedPreferences
  Future<void> cambiarTema() async {
    _modoOscuro = !_modoOscuro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', _modoOscuro);
  }

///Función que cambia el [tamaño] y guarda el dato en las SharedPreferences
  Future<void> cambiarTamanio(double nuevoTamanio) async {
    _tamanio = nuevoTamanio;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamanio', _tamanio);
  }

  ///Función que cambia el *[idioma]* y guarda el dato en las SharedPreferences
  Future<void> cambiarIdioma(String idioma) async {
    _idioma = idioma;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', _idioma);
  }
}

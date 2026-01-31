import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Clase que gestiona los aspectos relacionados con la apariencia de la aplicación
class TemaViewmodel extends ChangeNotifier {
  bool _modoOscuro = false;

  ///Variable que guarda la información relacionada con el modo oscuro
  bool get modoOscuro => _modoOscuro;

  ///Variable que devuelve el tema claro u oscuro en función de la variable modo oscuro
  ThemeMode get tema => _modoOscuro ? ThemeMode.dark : ThemeMode.light;
  String _idioma = "Español";

  ///Variable que guarda la información relacionada con el idioma
  String get idioma => _idioma;
  double _tamano = 1;

  ///Variable que guarda la información relacionada con el tamaño del texto
  double get tamano => _tamano;

  TemaViewmodel() {
    loadPrefs();
  }

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
    _idioma = prefs.getString('idioma') ?? "Español";
    _tamano = prefs.getDouble('tamano') ?? 1;
    notifyListeners();
  }

  ///Función que cambia el idioma de la aplicación
  Future<void> cambiarIdioma(String idioma) async {
    _idioma = idioma;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', idioma);
  }

  ///Función que cambia el tema de la aplicación
  Future<void> cambiarTema() async {
    _modoOscuro = !modoOscuro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', _modoOscuro);
  }

  ///Función que cambia el tamaño de la fuente de la aplicación
  Future<void> cambiarTamanio(double nuevoTamanio) async {
    _tamano = nuevoTamanio;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamano', _tamano);
  }
}

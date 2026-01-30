import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaViewmodel extends ChangeNotifier {
  bool _modoOscuro = false;
  bool get modoOscuro => _modoOscuro;
  ThemeMode get tema => _modoOscuro ? ThemeMode.dark : ThemeMode.light;
  String _idioma = "Español";
  String get idioma => _idioma;
  double _tamano = 1;
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

  Future<void> cambiarIdioma(String idioma) async {
    _idioma = idioma;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', idioma);
  }

  Future<void> cambiarTema() async {
    _modoOscuro = !modoOscuro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', _modoOscuro);
  }

  Future<void> cambiarTamanio(double nuevoTamanio) async {
    _tamano = nuevoTamanio;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamano', _tamano);
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaViewmodel extends ChangeNotifier {
  bool _modoOscuro = false;
  String _idioma = "Español";
  double _tamano = 1;

  bool get modoOscuro => _modoOscuro;
  String get idioma => _idioma;
  double get tamano => _tamano;
  ThemeMode get tema => _modoOscuro == true ? ThemeMode.dark : ThemeMode.light;

  TemaViewmodel() {
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
    _idioma = prefs.getString('idioma') ?? "Español";
    _tamano = prefs.getDouble('tamano') ?? 1;
    notifyListeners();
  }

  Future<void> cambiarTema() async {
    _modoOscuro = !_modoOscuro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', _modoOscuro);
  }

  Future<void> cambiarIdioma(String idioma) async {
    _idioma = idioma;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', _idioma);
  }

  Future<void> cambiarTamanio(double nuevoTamanio) async {
    _tamano = nuevoTamanio;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamano', _tamano);
  }
}

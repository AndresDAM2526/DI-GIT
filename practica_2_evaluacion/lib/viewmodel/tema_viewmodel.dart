import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaViewmodel extends ChangeNotifier {
  bool _modoOscuro=false;
  bool get modoOscuro => _modoOscuro;
  ThemeMode get tema => _modoOscuro ? ThemeMode.dark : ThemeMode.light;
  String _idioma = "es";
  String get idioma => _idioma;

  TemaViewmodel() {
    loadPrefs();
  }

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
    _idioma = prefs.getString('idioma') ?? "es";
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
}

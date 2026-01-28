import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjustesViewmodel extends ChangeNotifier {
  bool _modoOscuro = false;

  bool get modoOscuro => _modoOscuro;

  ThemeMode get tema => _modoOscuro ? ThemeMode.dark : ThemeMode.light;

  AjustesViewmodel() {
    cargarDatos();
  }

  void cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
    notifyListeners();
  }

  void cambiarModo() async {
    _modoOscuro = !_modoOscuro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', _modoOscuro);
    
  }
}

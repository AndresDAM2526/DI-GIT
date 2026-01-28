import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ContadorViewmodel extends ChangeNotifier {
  int _contador = 0;
  int get contador => _contador;

  ContadorViewmodel() {
    cargarDatos();
  }

  void incrementarContador() {
    _contador++;
    notifyListeners();
    guardarValor();
  }

  void decrementarContador() {
    _contador--;
    notifyListeners();
    guardarValor();
  }

  void cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    _contador = prefs.getInt('contador') ?? 0;
    notifyListeners();
  }

  void guardarValor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('contador', _contador);
    notifyListeners();
  }
}

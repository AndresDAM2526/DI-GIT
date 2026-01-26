import 'package:ejercicio_repaso/view/formulario_gastos_view.dart';
import 'package:ejercicio_repaso/view/formulario_usuarios_view.dart';
import 'package:flutter/material.dart';

class PantallaPrincipalView extends StatelessWidget {
  const PantallaPrincipalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Repaso"))),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Menú principal")),
            ListTile(
              title: Text("Gastos"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormularioGastos()),
              ),
            ),

            ListTile(
              title: Text("Usuarios"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormularioUsuarios()),
              ),
            ),
          ],
        ),
      ),
      body: Center(child: Text('Página principal')),
    );
  }
}

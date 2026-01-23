import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/model/producto_model.dart';
import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';

class CarritoView extends StatelessWidget {
  List<Producto> productos;
  CarritoView({super.key, required this.productos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Carrito"))),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productos[index].nombre),
            trailing: Text("${productos[index].precio}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DatabaseProvider>().crearFactura(productos);
          Navigator.pop(context);
        },
        child: Icon(Icons.payment),
      ),
    );
  }
}

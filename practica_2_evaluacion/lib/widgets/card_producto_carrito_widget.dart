import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica_2_evaluacion/model/producto_model.dart';
///Widget personalizado que muestra un widget de tipo Card para mostrar los productos del carrito 
class CardProductoCarritoWidget extends StatefulWidget {
  ///Variable de tipo producto
  Producto producto;
  ///Función usada para borrar un producto del carrito
  Function() borrar;
  CardProductoCarritoWidget({
    super.key,
    required this.producto,
    required this.borrar,
  });

  @override
  State<CardProductoCarritoWidget> createState() =>
      _CardProductoCarritoWidgetState();
}

class _CardProductoCarritoWidgetState extends State<CardProductoCarritoWidget> {
  @override
  Widget build(BuildContext context) {
    double precioFinal = widget.producto.cantidad * widget.producto.precio;
    final locale = Localizations.localeOf(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        child: ListTile(
          title: Text(
            widget.producto.nombre,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Cantidad: ${widget.producto.cantidad} · Precio: ${widget.producto.precio} · Total: ${NumberFormat.currency(locale: locale.toString()).format(precioFinal)} ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                widget.borrar();
              });
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

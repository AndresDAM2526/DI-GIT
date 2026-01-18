import 'package:flutter/material.dart';
import 'package:pratica_2_evaluacion/l10n/app_localizations.dart';
import 'package:pratica_2_evaluacion/main.dart';
import 'package:pratica_2_evaluacion/model/producto_model.dart';
import 'package:pratica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';

class modificarProducto extends StatefulWidget {
  int idProducto;
  modificarProducto({required this.idProducto});
  @override
  State<modificarProducto> createState() => _modificarProductoState();
}

class _modificarProductoState extends State<modificarProducto> {
  final validarFormulario = GlobalKey<FormState>();
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorCantidad = TextEditingController();
  TextEditingController controladorPrecio = TextEditingController();
  GlobalKey<FormFieldState> keyDropDown = GlobalKey();
  late Future<List<String>> categorias;
  String? categoriaSeleccionada;

  @override
  Widget build(BuildContext context) {
    final l10n= AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.titleModifyForm))),
      body: Form(
        key: validarFormulario,
        child: Column(
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controladorNombre,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Introduzca un nombre";
                    }
                  },
                  decoration: InputDecoration(label: Text(l10n!.nameForm)),
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: FutureBuilder(
                  future: context.read<DatabaseProvider>().cargarCategorias(),
                  builder: (context, snapshot) {
                    final categorias = snapshot.data!;
                    return DropdownButtonFormField(
                      key: keyDropDown,
                      validator: (value) {
                        if (value == null) {
                          return "Categoria no seleccionada";
                        }
                      },
                      hint: Text(l10n.selectCategoryForm),
                      items: categorias
                          .map(
                            (categoria) => DropdownMenuItem(
                              value: categoria,
                              child: Text(categoria),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          categoriaSeleccionada = value;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controladorCantidad,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Introduzca la cantidad";
                    } else if (int.tryParse(value) == null) {
                      return "El formato introducido es incorrecto";
                    }
                  },
                  decoration: InputDecoration(label: Text(l10n.quantityForm)),
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controladorPrecio,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Precio no introducido";
                    } else if (double.tryParse(value) == null) {
                      return "El formato introducido es incorrecto";
                    }
                  },
                  decoration: InputDecoration(label: Text(l10n.priceForm)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (validarFormulario.currentState!.validate()) {
                        Producto productoModificado = Producto(
                          idProducto: 0,
                          nombre: controladorNombre.text,
                          categoria: categoriaSeleccionada!,
                          cantidad: int.parse(controladorCantidad.text),
                          precio: double.parse(controladorPrecio.text),
                        );
                        context.read<DatabaseProvider>().modificarProducto(
                          widget.idProducto,
                          productoModificado,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(l10n.modifyButton),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controladorNombre.clear();
                      controladorCantidad.clear();
                      controladorPrecio.clear();
                      keyDropDown.currentState!.reset();
                    },
                    child: Text(l10n.clearFields),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pratica_2_evaluacion/l10n/app_localizations.dart';
import 'package:pratica_2_evaluacion/main.dart';
import 'package:pratica_2_evaluacion/model/producto_model.dart';
import 'package:pratica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:pratica_2_evaluacion/viewmodel/formulario_viewmodel.dart';
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
  String? categoriaSeleccionada;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.titleModifyForm))),
      body: Semantics(
        label:
            "Formulario para añadir modificar los datos de un producto seleccionado en la pestaña de inventario",
        child: Form(
          key: validarFormulario,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Semantics(
                      label: "Campo para introducir el nombre del producto",
                      hint:
                          "Campo donde se debe introducir el nuevo nombre del producto",
                      child: TextFormField(
                        controller: controladorNombre,
                        validator: (value) => context
                            .read<FormularioViewmodel>()
                            .validarNombre(value),
                        decoration: InputDecoration(label: Text(l10n.nameForm)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: context.read<DatabaseProvider>().cargarCategorias(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        final categorias = snapshot.data!;
                        return Semantics(
                          label: "Menú desplegable con las categorias",
                          hint:
                              "Se visualiza un menú desplegable donde se debe seleccionar la categoría del producto",
                          child: DropdownButtonFormField(
                            initialValue: categoriaSeleccionada,
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Semantics(
                      label: "Campo donde se introduce la cantidad",
                      hint:
                          "Campo donde se debe introducir un número entero, que corresponde con la cantidad del producto",
                      child: TextFormField(
                        controller: controladorCantidad,
                        validator: (value) => context
                            .read<FormularioViewmodel>()
                            .validarCantidad(value),
                        decoration: InputDecoration(
                          label: Text(l10n.quantityForm),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Semantics(
                      label: "Campo donde se introduce el precio",
                      hint:
                          "Campo donde se debe introducir un double, que corresponde con el precio del producto",
                      child: TextFormField(
                        controller: controladorPrecio,
                        validator: (value) => context
                            .read<FormularioViewmodel>()
                            .validarPrecio(value),
                        decoration: InputDecoration(label: Text(l10n.priceForm)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Semantics(
                      label: "Botón para enviar la modificación del producto",
                      hint:
                          "Al pulsar se comprobarán los datos introducidos por el usuario y si son correctos, se actualizará el producto en la base de datos",
                      child: ElevatedButton(
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
                    ),
                    Semantics(
                      label: "Botón para limpiar los campos",
                      hint:
                          "Al pulsar se borran los datos que se introdujeron en los campos",
                      child: ElevatedButton(
                        onPressed: () {
                          controladorNombre.clear();
                          controladorCantidad.clear();
                          controladorPrecio.clear();
                          keyDropDown.currentState!.reset();
                        },
                        child: Text(l10n.clearFields),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

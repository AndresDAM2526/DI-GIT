import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';
import 'package:practica_2_evaluacion/model/producto_model.dart';
import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:practica_2_evaluacion/viewmodel/formulario_viewmodel.dart';
import 'package:provider/provider.dart';

class anadirProductos extends StatefulWidget {
  @override
  State<anadirProductos> createState() => _anadirProductosState();
}

class _anadirProductosState extends State<anadirProductos> {
  late Future<List<String>> categorias;
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorCantidad = TextEditingController();
  TextEditingController controladorPrecio = TextEditingController();
  final validadFormulario = GlobalKey<FormState>();
  String? categoriaSeleccionada;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.titleForm))),
      body: Semantics(
        label: "Formulario para añadir un nuevo producto a la base de datos",
        hint: "Formulario que se debe rellenar para añadir un nuevo producto",
        child: Form(
          key: validadFormulario,
          child: Container(
            margin: EdgeInsets.all(20),
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
                            "Campo donde se debe introducir el nombre del nuevo producto",
                        child: TextFormField(
                          controller: controladorNombre,
                          validator: (value) => context
                              .read<FormularioViewmodel>()
                              .validarNombre(value),
                          decoration: InputDecoration(
                            label: Text(l10n.nameForm),
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
                      child: FutureBuilder(
                        future: context
                            .read<DatabaseProvider>()
                            .cargarCategorias(),
                        builder: (context, snapshot) {
                          final categorias = snapshot.data ?? [];
                          return Semantics(
                            label: "Menú desplegable con las categorias",
                            hint:
                                "Se visualiza un menú desplegable donde se debe seleccionar la categoría del producto",
                            child: DropdownButtonFormField(
                              validator: (value) => context
                                  .read<FormularioViewmodel>()
                                  .validarCategoria(value),
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
                          decoration: InputDecoration(
                            label: Text(l10n.priceForm),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Semantics(
                    label: "Botón para añadir un producto",
                    hint: "Botón para añadir un nuevo producto a la base de datos",
                    child: ElevatedButton(
                      onPressed: () {
                        if (validadFormulario.currentState!.validate()) {
                          Producto nuevoProducto = Producto(
                            idProducto: 0,
                            nombre: controladorNombre.text,
                            categoria: categoriaSeleccionada!,
                            cantidad: int.parse(controladorCantidad.text),
                            precio: double.parse(controladorPrecio.text),
                          );
                          context.read<DatabaseProvider>().anadirProducto(
                            nuevoProducto,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(l10n.addButtonForm),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
///Widget personalizado usado para pedir la cantidad en el momento de añadir un producto al carrito
class DialogoCantidadWidget extends StatelessWidget {
  const DialogoCantidadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final validarFormulario = GlobalKey<FormState>();
    final cantidad = TextEditingController();
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: validarFormulario,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: cantidad,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Introduzca una cantidad";
                    } else if (int.tryParse(value) == null) {
                      return "El formato del número no es correcto";
                    }
                  },
                  decoration: InputDecoration(
                    label: Text("Cantidad"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (validarFormulario.currentState!.validate()) {
                  Navigator.pop(context, int.parse(cantidad.text));
                }
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:actividad_1/viewmodel/contador_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContadorView extends StatefulWidget {
  const ContadorView({super.key});

  @override
  State<ContadorView> createState() => _ContadorViewState();
}

class _ContadorViewState extends State<ContadorView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Has pulsado: ${context.watch<ContadorViewmodel>().contador}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.read<ContadorViewmodel>().incrementarContador();
                },
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<ContadorViewmodel>().decrementarContador();
                },
                child: Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

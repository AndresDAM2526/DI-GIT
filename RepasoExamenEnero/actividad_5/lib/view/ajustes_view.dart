import 'package:actividad_5/viewmodel/ajustes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjustesView extends StatefulWidget {
  const AjustesView({super.key});

  @override
  State<AjustesView> createState() => _AjustesViewState();
}

class _AjustesViewState extends State<AjustesView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AjustesViewmodel>();
    return Center(
      child: Switch(
        value: viewModel.modoOscuro,
        onChanged: (value) {
          setState(() {
            viewModel.cambiarModo();
          });
        },
      ),
    );
  }
}

import 'package:actividad_2/viewmodel/card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CardViewmodel>();
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          color: Colors.grey,
          width: 500,
          height: 300,
        ),
        Positioned(
          left: 50,
          top: 50,
          child: CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(viewModel.usuario.foto),
          ),
        ),
        Positioned(left: 250,top: 125,child: Text(viewModel.usuario.nombre,style: TextStyle(fontSize: 40),))
      ],
    );
  }
}

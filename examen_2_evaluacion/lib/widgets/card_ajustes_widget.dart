import 'package:flutter/material.dart';

class CardAjustesWidget extends StatefulWidget {
  String titulo;
  Widget elemento;

  CardAjustesWidget({super.key, required this.titulo, required this.elemento});

  @override
  State<CardAjustesWidget> createState() => _CardAjustesWidgetState();
}

class _CardAjustesWidgetState extends State<CardAjustesWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  widget.titulo,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            widget.elemento,
          ],
        ),
      ),
    );
  }
}

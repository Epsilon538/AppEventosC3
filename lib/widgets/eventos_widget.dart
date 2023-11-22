import 'package:flutter/material.dart';

class eventos_widget extends StatefulWidget {
  const eventos_widget({
    required this.nombre,
    required this.fecha,
    required this.hora,
    required this.lugar,
    required this.descripcion,
    required this.tipo,
    required this.likes,
  });

  final String nombre;
  final DateTime fecha;
  final String hora;
  final String lugar;
  final String descripcion;
  final String tipo;
  final int likes;

  @override
  State<eventos_widget> createState() => _eventos_widgetState();
}

class _eventos_widgetState extends State<eventos_widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          
      ]),
    );
  }
}
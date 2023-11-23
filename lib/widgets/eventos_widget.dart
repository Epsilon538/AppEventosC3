import 'package:flutter/material.dart';

class eventos_widget extends StatelessWidget {
  const eventos_widget({
    required this.nombre,
    required this.fechaHora,
    required this.lugar,
    required this.descripcion,
    required this.tipo,
    required this.estado,
    required this.likes,
    required this.imageUrl,
  });
  
  final String nombre;
  final DateTime fechaHora;
  final String lugar;
  final String descripcion;
  final String tipo;
  final String estado;
  final int likes;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nombre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text('Fecha: ${fechaHora.day}/${fechaHora.month}/${fechaHora.year}'),
                Text('Hora: ${fechaHora.hour}:${fechaHora.minute}'),
                Text('Lugar: $lugar'),
                SizedBox(height: 8),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.thumb_up),
                    SizedBox(width: 4),
                    Text('$likes likes'),
                  ],
                ),
              ],
            ),
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(image: NetworkImage('$imageUrl'),
                      fit: BoxFit.cover),
                    ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


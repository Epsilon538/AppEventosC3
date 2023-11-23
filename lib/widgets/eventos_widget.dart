import 'package:flutter/material.dart';

class eventos_widget extends StatelessWidget {
  const eventos_widget({
    required this.nombre,
    required this.fecha,
    required this.hora,
    required this.lugar,
    required this.descripcion,
    required this.tipo,
    required this.imageUrl,
  });
  
  final String nombre;
  final DateTime fecha;
  final TimeOfDay hora;
  final String lugar;
  final String descripcion;
  final String tipo;
  final String imageUrl;
  final int likes = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text('Fecha: ${fecha.day}/${fecha.month}/${fecha.year}'),
                Text('Hora: ${hora.hour}:${hora.minute}'),
                Text('Lugar: $lugar'),
                Text('Tipo: $tipo'),
                SizedBox(height: 8),
                Text(
                  'Descripción:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(descripcion),
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
            Container(
              child: Image(image: NetworkImage('$imageUrl')),
            )
          ],
        ),
      ),
    );
  }
}

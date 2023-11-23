import 'package:app_eventos/widgets/eventos_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            eventos_widget(nombre: 'Evento anime', fecha: DateTime(2023, 12, 25), hora:TimeOfDay.now(), lugar: 'Quilpue', descripcion: 'ligoleyen', tipo: 'convencion'),
            eventos_widget(nombre: 'Evento anime', fecha: DateTime(2023, 12, 25), hora:TimeOfDay.now(), lugar: 'Quilpue', descripcion: 'ligoleyen', tipo: 'convencion')
          ],
        )
      ),
    );
  }
}
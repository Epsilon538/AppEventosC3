import 'package:app_eventos/models/evento.dart';
import 'package:app_eventos/widgets/eventos_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventosPage extends StatefulWidget {
  const EventosPage({super.key});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('eventos').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error al obtener los datos');
            }

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Evento evento =
                      Evento.fromSnapshot(snapshot.data!.docs[index]);
                  print(evento.imagen);
                  return eventos_widget(
                      nombre: evento.nombre,
                      fechaHora: evento.fechaHora,
                      lugar: evento.lugar,
                      descripcion: evento.desc,
                      tipo: evento.tipo,
                      estado: evento.estado,
                      likes: evento.likes,
                      imageUrl: evento.imagen);
                },
              );
            }

            return Text('No hay datos disponibles');
          },
        ),
      ),
    );
  }
}

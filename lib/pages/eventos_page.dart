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
          stream: FirebaseFirestore.instance
              .collection('eventos')
              .where('estado', isEqualTo: 'Pendiente')
              .snapshots(),
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
                  if (evento.fechaHora
                      .isBefore(DateTime.now().add(Duration(days: 3)))) {
                    return eventos_widget(
                      evento: evento,
                      destacado: true,
                    );
                  } else {
                    return eventos_widget(
                      evento: evento,
                      destacado: false,
                    );
                  }
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

import 'package:app_eventos/models/evento.dart';
import 'package:app_eventos/widgets/eventos_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FinalizadosPage extends StatelessWidget {
  const FinalizadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('eventos')
              .where('estado', isNotEqualTo: 'Pendiente')
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
                  return eventos_widget(
                    evento: evento,
                  );
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

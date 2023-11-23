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
                  var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  
                  return eventos_widget(
                    nombre: data['nombre'], 
                    fechaHora: data['fechaHora'], 
                    lugar: data['nombre'], 
                    descripcion: data['nombre'], 
                    tipo: data['nombre'], 
                    estado : data['nombre'],
                    likes : data['nombre'],
                    imageUrl: data['nombre']);
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

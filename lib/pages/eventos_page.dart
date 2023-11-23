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
              return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
            }

            if (snapshot.hasError) {
              return Text('Error al obtener los datos'); // Maneja los errores de obtención de datos
            }

            // Si hay datos disponibles, muestra la lista
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  // Aquí puedes personalizar cómo se muestra cada elemento de la lista
                  return eventos_widget(nombre: nombre, fecha: fecha, hora: hora, lugar: lugar, descripcion: descripcion, tipo: tipo, imageUrl: imageUrl,)
                },
              );
            }

            // Si no hay datos, muestra un mensaje indicando que no hay elementos
            return Text('No hay datos disponibles');
          },
        ),
      ),
    );
  }
}

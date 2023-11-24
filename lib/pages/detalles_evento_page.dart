import 'package:app_eventos/models/evento.dart';
import 'package:app_eventos/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class detallesEvento extends StatelessWidget {
  detallesEvento({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Card(
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirestoreService().eventoUnico(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print(id);
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error al obtener los datos');
              }

              if (snapshot.hasData && snapshot.data!.exists) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    Evento evento = Evento.fromSnapshot(snapshot.data!);
                    print('evento ${evento.id}');
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image(
                                  image: NetworkImage(evento.imagen),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nombre: ' + evento.nombre,
                                  style: TextStyle(fontSize: 20)),
                              Text('Lugar: ' + evento.lugar,
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                  'Fecha: ' +
                                      evento.fechaHora.day.toString() +
                                      '/' +
                                      evento.fechaHora.month.toString() +
                                      '/' +
                                      evento.fechaHora.year.toString(),
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                  'Hora: ' +
                                      evento.fechaHora.hour
                                          .toString()
                                          .padLeft(2, '0') +
                                      ':' +
                                      evento.fechaHora.minute
                                          .toString()
                                          .padLeft(2, '0'),
                                  style: TextStyle(fontSize: 20)),
                              Text('Tipo: ' + evento.tipo,
                                  style: TextStyle(fontSize: 20)),
                              Text('Me gusta: ' + evento.likes.toString(),
                                  style: TextStyle(fontSize: 20)),
                              Text('Descripcion: ' + evento.desc,
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }

              return Text('No hay datos disponibles');
            },
          ),
        ));
  }
}

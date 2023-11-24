import 'package:app_eventos/models/evento.dart';
import 'package:app_eventos/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class detallesEvento extends StatefulWidget {
  detallesEvento({required this.id});

  String id;

  @override
  State<detallesEvento> createState() => _detallesEventoState();
}

class _detallesEventoState extends State<detallesEvento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService().eventos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print(widget.id);
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error al obtener los datos');
            }

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Evento evento = Evento.fromSnapshot(snapshot.data!.docs[index]);
                  print('evento ${evento.id}');
                  while (evento.id == widget.id){
                    return Column(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 15),
                          width: 300,
                          height: 300,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                                image: NetworkImage(evento.imagen), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(evento.nombre)
                          ],
                        ),
                      ),
                      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(MdiIcons.console))                    
                    ],
                  );
                  }
                },
              );
            }

            return Text('No hay datos disponibles');
          },
        ),
      )
    );
  }
}
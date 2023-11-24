import 'package:app_eventos/pages/detalles_evento_page.dart';
import 'package:app_eventos/services/auth_service.dart';
import 'package:app_eventos/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    required this.id,
  });

  final String nombre;
  final DateTime fechaHora;
  final String lugar;
  final String descripcion;
  final String tipo;
  final String estado;
  final int likes;
  final String imageUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    bool estadoLike = true;
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                          'Fecha: ${fechaHora.day}/${fechaHora.month}/${fechaHora.year}'),
                      Text('Hora: ${fechaHora.hour}:${fechaHora.minute}'),
                      Text('Lugar: $lugar'),
                      Text('Estado: $estado'),
                      Text('Me gusta: $likes'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up),
                            onPressed: () {
                              if(estadoLike == true) {
                                int nuevoLike = likes + 1;
                                FirestoreService().actualizarLike(id, nuevoLike);
                                estadoLike = false;
                              } else {
                                int nuevoLike = likes - 1;
                                FirestoreService().actualizarLike(id, nuevoLike);
                                estadoLike = true;
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(MdiIcons.eye),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => detallesEvento()));
                            },
                          ),
                          StreamBuilder(
                            stream: AuthService().usuario,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (FirebaseAuth
                                      .instance.currentUser?.displayName !=
                                  null) {
                                return IconButton(
                                    icon: Icon(MdiIcons.trashCan),
                                    onPressed: () async {
                                      await FirestoreService().eventoBorrar(id);
                                    });
                              } else {
                                return Container();
                              }
                            },
                          ),
                          StreamBuilder(
                            stream: AuthService().usuario,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (FirebaseAuth
                                      .instance.currentUser?.displayName !=
                                  null) {
                                return IconButton(
                                    icon: Icon(MdiIcons.cog),
                                    onPressed: () async {
                                      await FirestoreService().eventoBorrar(id);
                                    });
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                      image: NetworkImage('$imageUrl'), fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

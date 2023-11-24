import 'package:app_eventos/pages/detalles_evento_page.dart';
import 'package:app_eventos/services/auth_service.dart';
import 'package:app_eventos/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  });
  
  final String nombre;
  final DateTime fechaHora;
  final String lugar;
  final String descripcion;
  final String tipo;
  final String estado;
  final int likes;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(height: 8),
                  Text('Fecha: ${fechaHora.day}/${fechaHora.month}/${fechaHora.year}'),
                  Text('Hora: ${fechaHora.hour}:${fechaHora.minute}'),
                  Text('Lugar: $lugar'),
                  SizedBox(height: 8),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.thumb_up),
                          Text('$likes'),
                        ],
                      ),
                      IconButton(icon: Icon(MdiIcons.eye), 
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => detallesEvento()));
                        },),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: AuthService().usuario, 
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (FirebaseAuth.instance.currentUser?.displayName != null) {
                  return IconButton(icon: Icon(MdiIcons.trashCan), onPressed: () async {
                    await FirestoreService().eventoBorrar('$nombre');
                    });
                } else {
                  return Container();
                }
              },
            ),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(image: NetworkImage('$imageUrl'),
                      fit: BoxFit.cover),
                    ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


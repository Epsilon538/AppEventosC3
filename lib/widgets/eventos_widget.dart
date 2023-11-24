import 'package:app_eventos/pages/detalles_evento_page.dart';
import 'package:app_eventos/services/auth_service.dart';
import 'package:app_eventos/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class eventos_widget extends StatefulWidget {
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
  State<eventos_widget> createState() => _eventos_widgetState();
}

class _eventos_widgetState extends State<eventos_widget> {
  bool estadoLike = true;
  Color colorLike = Colors.black87;
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                          'Fecha: ${widget.fechaHora.day}/${widget.fechaHora.month}/${widget.fechaHora.year}'),
                      Text(
                          'Hora: ${widget.fechaHora.hour.toString().padLeft(2, '0')}:${widget.fechaHora.minute.toString().padLeft(2, '0')}'),
                      Text('Lugar: ${widget.lugar}'),
                      Text('Estado: ${widget.estado}'),
                      Text('Me gusta: ${widget.likes}'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up, color: colorLike),
                            onPressed: () {
                              if (estadoLike == true) {
                                int nuevoLike = widget.likes + 1;
                                FirestoreService()
                                    .actualizarLike(widget.id, nuevoLike);
                                estadoLike = false;
                                colorLike = Colors.lightGreen;
                              } else {
                                int nuevoLike = widget.likes - 1;
                                FirestoreService()
                                    .actualizarLike(widget.id, nuevoLike);
                                estadoLike = true;
                                colorLike = Colors.black87;
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(MdiIcons.eye),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          detallesEvento(id: widget.id)));
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('¿Esta seguro de eliminar el evento?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () async{
                                                  await FirestoreService().eventoBorrar(widget.id);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Aceptar')
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context); // Cerrar la alerta
                                                },
                                                child: Text('Cancelar'),
                                              ),
                                              
                                            ],
                                          );
                                        },
                                      );
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('¿Esta seguro de eliminar el evento?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  FirestoreService().actualizarEstado(id, estado);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Aceptar')
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context); // Cerrar la alerta
                                                },
                                                child: Text('Cancelar'),
                                              ),
                                              
                                            ],
                                          );
                                        },
                                      );
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
                      image: NetworkImage('${widget.imageUrl}'),
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

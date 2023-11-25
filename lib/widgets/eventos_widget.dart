import 'package:app_eventos/models/evento.dart';
import 'package:app_eventos/pages/detalles_evento_page.dart';
import 'package:app_eventos/services/auth_service.dart';
import 'package:app_eventos/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class eventos_widget extends StatefulWidget {
  const eventos_widget({
    required this.evento,
    required this.destacado,
  });

  final bool destacado;
  final Evento evento;

  @override
  State<eventos_widget> createState() => _eventos_widgetState();
}

class _eventos_widgetState extends State<eventos_widget> {
  bool estadoLike = true;
  Color colorLike = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          widget.destacado ? Colors.orange.shade100 : Colors.lightGreen.shade50,
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
                        widget.evento.nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                          'Fecha: ${widget.evento.fechaHora.day}/${widget.evento.fechaHora.month}/${widget.evento.fechaHora.year}'),
                      Text(
                          'Hora: ${widget.evento.fechaHora.hour.toString().padLeft(2, '0')}:${widget.evento.fechaHora.minute.toString().padLeft(2, '0')}'),
                      Text('Lugar: ${widget.evento.lugar}'),
                      Text('Estado: ${widget.evento.estado}'),
                      Text('Me gusta: ${widget.evento.likes}'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up, color: colorLike),
                            onPressed: () {
                              if (estadoLike == true) {
                                int nuevoLike = widget.evento.likes + 1;
                                FirestoreService().actualizarLike(
                                    widget.evento.id, nuevoLike);
                                estadoLike = false;
                                colorLike = Colors.lightGreen;
                              } else {
                                int nuevoLike = widget.evento.likes - 1;
                                FirestoreService().actualizarLike(
                                    widget.evento.id, nuevoLike);
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
                                      builder: (context) => detallesEvento(
                                          id: widget.evento.id)));
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
                                            title: Text('¿Esta seguro?'),
                                            content: Text(
                                                'Evento a eliminar: ${widget.evento.nombre}'),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        await FirestoreService()
                                                            .eventoBorrar(widget
                                                                .evento.id);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Aceptar')),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Cerrar la alerta
                                                    },
                                                    child: Text('Cancelar'),
                                                  ),
                                                ],
                                              )
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
                                            title: Text('Cambiar estado'),
                                            content: Text(
                                                'Evento: ${widget.evento.nombre}'),
                                            actions: [
                                              Row(
                                                children: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        await FirestoreService()
                                                            .actualizarEstado(
                                                                widget
                                                                    .evento.id,
                                                                'Finalizado');
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          Text('Finalizado')),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await FirestoreService()
                                                            .actualizarEstado(
                                                                widget
                                                                    .evento.id,
                                                                'Cancelado');
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancelado')),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await FirestoreService()
                                                            .actualizarEstado(
                                                                widget
                                                                    .evento.id,
                                                                'Pendiente');
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Pendiente')),
                                                ],
                                              )
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
                      image: NetworkImage('${widget.evento.imagen}'),
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

import 'dart:io';

import 'package:app_eventos/services/firestore_service.dart';
import 'package:app_eventos/services/select_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class AgregarEventoPage extends StatefulWidget {
  @override
  _AgregarEventoPageState createState() => _AgregarEventoPageState();
}

class _AgregarEventoPageState extends State<AgregarEventoPage> {
  
  TextEditingController nombreController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime fechaEvento = DateTime.now();
  final formatoFecha = DateFormat('dd-MM-yyyy');
  TimeOfDay horaEvento = TimeOfDay.now();

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat.jm();
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {

    File? imageSubir;
    
    String formattedTime = formatTimeOfDay(horaEvento);

    DateTime guardarFechaHora() {
      DateTime fechaHora = DateTime(
        fechaEvento.year,
        fechaEvento.month,
        fechaEvento.day,
        horaEvento.hour,
        horaEvento.minute,
      );
      return fechaHora;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar eventos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del Evento',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa el nombre del evento';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: lugarController,
                  decoration: InputDecoration(
                    labelText: 'Lugar',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa el lugar del evento';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa una descripcion del evento';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: tipoController,
                  decoration: InputDecoration(
                    labelText: 'Tipo',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingresa el tipo del evento';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Row(
                    children: [
                      Text('Fecha del evento: '),
                      Text(formatoFecha.format(fechaEvento), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Spacer(),
                      IconButton(
                        icon: Icon(MdiIcons.calendar),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          ).then((fecha) {
                            setState(() {
                              fechaEvento = fecha ?? fechaEvento;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text('Hora del evento: '),
                      Text(formattedTime, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Spacer(),
                      IconButton(
                        icon: Icon(MdiIcons.clock),
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((hora) {
                            setState(() {
                              horaEvento = hora ?? horaEvento;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 45, 184, 27)
                        ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                            FirestoreService().eventoAgregar(
                              nombreController.text.trim(),
                              guardarFechaHora(),
                              lugarController.text.trim(),
                              descripcionController.text.trim(),
                              tipoController.text.trim(),
                              imageSubir!,
                            );
                        }
                      },
                      child: Text('Enviar', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Text('Agregar imagen', style: TextStyle(color: Colors.black)),
                            Icon(MdiIcons.image, color: Colors.black,),
                          ],
                        ),
                        onPressed: () async{
                          final XFile? imagen = await getImage();
                          setState(() {
                            imageSubir = File(imagen!.path);
                          });
                        },
                      )
                    )
                  ],
                )
              ]
            ),
          ),
        ),
      )
    );
  }
}
import 'package:app_eventos/services/google-sign-in.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola mundo'),
        leading: Icon(MdiIcons.firebase, color: Colors.yellow.shade700),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [PopupMenuItem(child: Text('Iniciar Sesion'), value: 'login')],
            onSelected: (opcion) async {
              await signInWithGoogle();
            },
          ),
        ],
      ),
    );
  }
}
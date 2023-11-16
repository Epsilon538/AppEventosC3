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
      ),
      body: Container(
        child: IconButton(
          onPressed: () async{
            await signInWithGoogle();
          },
          icon: Icon(Icons.add_box)),
      ),
    );
  }
}
import 'package:app_eventos/services/google-sign-in.dart';
import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.gif_box),
          onPressed: () async{
            await iniciarSesionConGoogle();
          },
          ),
      ),
    );
  }
}
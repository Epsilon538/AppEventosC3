import 'package:app_eventos/services/google-sign-in.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Iniciar Sesion'),
                IconButton(
                  icon: Icon(MdiIcons.google),
                  onPressed: () async{
                    await iniciarSesionConGoogle();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
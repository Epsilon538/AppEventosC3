import 'package:app_eventos/services/auth_service.dart';
import 'package:app_eventos/services/google-sign-in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade200,
        title: Text('Iniciar sesión'),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  width: 150,
                  height: 150,
                  child: Center(
                    child:
                        FirebaseAuth.instance.currentUser?.photoURL != null &&
                                FirebaseAuth
                                    .instance.currentUser!.photoURL!.isNotEmpty
                            ? Image.network(
                                FirebaseAuth.instance.currentUser!.photoURL!,
                              )
                            : Image.asset(
                                'assets/images/user_default.png',
                              ),
                  ),
                ),
                Text(
                    FirebaseAuth.instance.currentUser?.displayName != null
                        ? 'Logged as ${FirebaseAuth.instance.currentUser?.displayName ?? 'Unknown'}'
                        : 'Not logged',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 100),
                Text('Iniciar Sesion'),
                IconButton(
                  icon: Icon(MdiIcons.google),
                  onPressed: () async {
                    try{
                      await iniciarSesionConGoogle();
                      setState(() {});
                    }on PlatformException catch(e){
                      return showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error inesperado'),
                            actions: [
                              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Aceptar'))
                            ],
                          );
                        }
                      );
                    }
                    
                  },
                ),
                StreamBuilder(
                    stream: AuthService().usuario,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (FirebaseAuth.instance.currentUser?.displayName !=
                          null) {
                        return Column(
                          children: [
                            Text('Cerrar Sesion'),
                            IconButton(
                              icon: Icon(MdiIcons.logout),
                              onPressed: () async {
                                FirebaseAuth.instance.signOut();
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

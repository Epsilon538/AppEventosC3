import 'package:app_eventos/services/google-sign-in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: FirebaseAuth.instance.currentUser?.photoURL != null && FirebaseAuth.instance.currentUser!.photoURL!.isNotEmpty
                            ? Image.network(
                                FirebaseAuth.instance.currentUser!.photoURL!,
                              )
                            : Image.asset(
                                'assets/images/user_default.png',
                              ),
                    //Image(image: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL.toString()) ?? Image.asset('assets/images/user_default.png')),   
                  ),
                ),
                Text(FirebaseAuth.instance.currentUser?.displayName != null ? 'Logued as ${FirebaseAuth.instance.currentUser?.displayName ?? 'Unknown'}': 'Not logued', style: TextStyle(fontSize: 15)),                   
                SizedBox(height: 100),
                Text('Iniciar Sesion'),
                IconButton(
                  icon: Icon(MdiIcons.google),
                  onPressed: () async {
                    await iniciarSesionConGoogle();
                    setState(() {
                      
                    });
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

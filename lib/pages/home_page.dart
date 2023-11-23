import 'package:app_eventos/pages/agregar_evento_page.dart';
import 'package:app_eventos/pages/eventos_page.dart';
import 'package:app_eventos/pages/finalizados_page.dart';
import 'package:app_eventos/pages/login_page.dart';
import 'package:app_eventos/pages/proximos_page.dart';
import 'package:app_eventos/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AgregarEventoPage()));
            }),
        appBar: AppBar(
          actions: [
            StreamBuilder(
                stream: AuthService().usuario,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (FirebaseAuth.instance.currentUser?.displayName != null) {
                    return PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Cerrar sesión'),
                          value: 'cerrar',
                        )
                      ],
                      onSelected: (value) {
                        FirebaseAuth.instance.signOut();
                      },
                    );
                  } else {
                    return PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Iniciar sesión'),
                          value: 'iniciar',
                        )
                      ],
                      onSelected: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    );
                  }
                })
          ],
          title: Text('Eventasos'),
          bottom: TabBar(tabs: [
            Tab(
              text: 'Proximos',
            ),
            Tab(
              text: 'Eventos',
            ),
            Tab(
              text: 'Finalizados',
            )
          ]),
        ),
        body: TabBarView(
            children: [ProximosPage(), EventosPage(), FinalizadosPage()]),
      ),
    );
  }
}

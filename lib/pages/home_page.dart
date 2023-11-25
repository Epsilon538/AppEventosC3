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
      initialIndex: 1,
      child: Scaffold(
        floatingActionButton: StreamBuilder(
            stream: AuthService().usuario,
            builder: (context, snapshot) {
              if (FirebaseAuth.instance.currentUser?.displayName != null) {
                return FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgregarEventoPage()));
                    });
              } else {
                return Text('Grupaso Corp™');
              }
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
                          child: Text('Cuenta'),
                          value: 'cuenta',
                        )
                      ],
                      onSelected: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
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
          leading: Icon(Icons.calendar_month_outlined),
          title: Text('Eventasos™'),
          backgroundColor: Colors.lightGreen.shade200,
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

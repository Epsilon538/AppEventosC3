import 'package:app_eventos/pages/agregar_evento_page.dart';
import 'package:app_eventos/pages/eventos_page.dart';
import 'package:app_eventos/pages/finalizados_page.dart';
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
        appBar: AppBar(
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

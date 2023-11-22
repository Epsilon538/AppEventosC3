import 'package:app_eventos/pages/homePage.dart';
import 'package:app_eventos/pages/loginPage.dart';
import 'package:app_eventos/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _homeState();
}

class _homeState extends State<Index> {

  Widget paginaActual = HomePage();
  int destino = 0;

  void navegar(BuildContext context, int destino){
    switch (destino){
      case 1:
        paginaActual = HomePage();
        break;
      case 2:
        paginaActual = LoginPage();
        break;
    }
    Navigator.pop(context);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text('Menu'),
                  ),
                  Container(
                    child: ListTile(
                      title: Text('Pagina principal'),
                      onTap: () {
                        destino = 1;
                        navegar(context, destino);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    child: ListTile(
                      title: Text('Iniciar Sesion como Administrador'),
                      onTap: () {
                        destino = 2;
                        navegar(context, destino);
                      },
                    ),
                  ),
                  
                ],
              ),
            ),
          StreamBuilder(
            stream: AuthService().usuario, 
            builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(FirebaseAuth.instance.currentUser?.displayName == null)
              {
                return Container();
              } else {
                return InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cerrar Sesion ', style: TextStyle(fontSize:  20)),
                      Icon(MdiIcons.logout, size: 30),
                    ],
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    destino = 1;
                    navegar(context, destino);
                  },
                );
              }
            }
          ),
        ],
        ),
      ),
      body: paginaActual,
    );
  }
}
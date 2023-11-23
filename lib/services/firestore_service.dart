import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  Future<void> eventoAgregar(String nombre, DateTime fechaHora, String lugar, String descripcion, String tipo, String estado, String imagen) async {
    return FirebaseFirestore.instance.collection('eventos').doc().set({
      'nombre': nombre,
      'fechaHora' : fechaHora,
      'lugar' : lugar,
      'descripcion' : descripcion,
      'tipo' : tipo,
      'estado' : estado,
      'imagen' : imagen
    });
  }

  Future<void> eventoBorrar(String docId) async {
    return FirebaseFirestore.instance.collection('eventos').doc(docId).delete();
  }

  Future<QuerySnapshot> getEventos() async {
    return FirebaseFirestore.instance.collection('eventos').get();
  }
}

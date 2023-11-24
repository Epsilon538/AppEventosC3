import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  Future<void> eventoAgregar(
      String nombre,
      DateTime fechaHora,
      String lugar,
      String descripcion,
      String tipo,
      String estado,
      int likes,
      String imagen) async {
    return FirebaseFirestore.instance.collection('eventos').doc().set({
      'nombre': nombre,
      'fechaHora': fechaHora,
      'lugar': lugar,
      'descripcion': descripcion,
      'tipo': tipo,
      'estado': estado,
      'likes': likes,
      'imagen': imagen
    });
  }

  Future<void> eventoBorrar(String id) async {
    return FirebaseFirestore.instance.collection('eventos').doc(id).delete();
  }

  void actualizarLike(String id, int like) async {
      DocumentReference documentReference = FirebaseFirestore.instance.collection('eventos').doc(id);
      await documentReference.update({
        'likes' : like
      });
  }

  Stream<QuerySnapshot> getEventoUnico(String id) {
    return FirebaseFirestore.instance.collection('eventos').where('id', isEqualTo: id).snapshots();
  }

}

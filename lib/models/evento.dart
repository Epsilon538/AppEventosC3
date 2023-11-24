class Evento {
  String _nombre;
  DateTime _fechaHora;
  String _lugar;
  String _desc;
  String _tipo;
  String _estado;
  int _likes;
  String _imagen;
  String _id;

  Evento(
      {nombre = '',
      lugar = '',
      desc = '',
      tipo = '',
      estado = '',
      like = 0,
      img = '',
      id = ''})
      : _nombre = nombre,
        _lugar = lugar,
        _desc = desc,
        _tipo = tipo,
        _estado = estado,
        _likes = like,
        _imagen = img,
        _fechaHora = DateTime.now(),
        _id = id;

  Evento.fromSnapshot(dynamic snapshot)
      : _nombre = snapshot['nombre'],
        _lugar = snapshot['lugar'],
        _desc = snapshot['descripcion'],
        _tipo = snapshot['tipo'],
        _estado = snapshot['estado'],
        _likes = snapshot['likes'],
        _imagen = snapshot['imagen'],
        _fechaHora = snapshot['fechaHora'].toDate(),
        _id = snapshot.id;

  String get nombre => this._nombre;
  DateTime get fechaHora => this._fechaHora;
  String get lugar => this._lugar;
  String get desc => this._desc;
  String get tipo => this._tipo;
  String get estado => this._estado;
  int get likes => this._likes;
  String get imagen => this._imagen;
  String get id => this._id;
}

class Usuario {
  String _idUsuario;
  String _nome;
  String _email;
  String _senha;

  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "nome": this.nome,
      "email": this.email
    };

    return map;
  }

  // ignore: unnecessary_getters_setters
  String get senha => _senha;

  // ignore: unnecessary_getters_setters
  set senha(String value) {
    _senha = value;
  }

  // ignore: unnecessary_getters_setters
  String get email => _email;

  // ignore: unnecessary_getters_setters
  set email(String value) {
    _email = value;
  }

  // ignore: unnecessary_getters_setters
  String get nome => _nome;

  // ignore: unnecessary_getters_setters
  set nome(String value) {
    _nome = value;
  }

  // ignore: unnecessary_getters_setters
  String get idUsuario => _idUsuario;

  // ignore: unnecessary_getters_setters
  set idUsuario(String value) {
    _idUsuario = value;
  }
}

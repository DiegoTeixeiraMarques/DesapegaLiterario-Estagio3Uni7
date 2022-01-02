import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class Anuncio {
  String _id;
  String _estado;
  String _categoria;
  String _titulo;
  String _preco;
  String _telefone;
  String _descricao;
  List<String> _fotos;

  Anuncio();

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.documentID;
    this.estado = documentSnapshot["estado"];
    this.categoria = documentSnapshot["categoria"];
    this.titulo = documentSnapshot["titulo"];
    this.preco = documentSnapshot["preco"];
    this.telefone = documentSnapshot["telefone"];
    this.descricao = documentSnapshot["descricao"];
    this.fotos = List<String>.from(documentSnapshot["fotos"]);
  }

  Anuncio.gerarId() {
    Firestore db = Firestore.instance;
    CollectionReference anuncios = db.collection("meus_anuncios");
    this.id = anuncios.document().documentID;

    this.fotos = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "estado": this.estado,
      "categoria": this.categoria,
      "titulo": this.titulo,
      "preco": this.preco,
      "telefone": this.telefone,
      "descricao": this.descricao,
      "fotos": this.fotos,
    };

    return map;
  }

  // ignore: unnecessary_getters_setters
  List<String> get fotos => _fotos;

  // ignore: unnecessary_getters_setters
  set fotos(List<String> value) {
    _fotos = value;
  }

  // ignore: unnecessary_getters_setters
  String get descricao => _descricao;

  // ignore: unnecessary_getters_setters
  set descricao(String value) {
    _descricao = value;
  }

  // ignore: unnecessary_getters_setters
  String get telefone => _telefone;

  // ignore: unnecessary_getters_setters
  set telefone(String value) {
    _telefone = value;
  }

  // ignore: unnecessary_getters_setters
  String get preco => _preco;

  // ignore: unnecessary_getters_setters
  set preco(String value) {
    _preco = value;
  }

  // ignore: unnecessary_getters_setters
  String get titulo => _titulo;

  // ignore: unnecessary_getters_setters
  set titulo(String value) {
    _titulo = value;
  }

  // ignore: unnecessary_getters_setters
  String get categoria => _categoria;

  // ignore: unnecessary_getters_setters
  set categoria(String value) {
    _categoria = value;
  }

  // ignore: unnecessary_getters_setters
  String get estado => _estado;

  // ignore: unnecessary_getters_setters
  set estado(String value) {
    _estado = value;
  }

  // ignore: unnecessary_getters_setters
  String get id => _id;

  // ignore: unnecessary_getters_setters
  set id(String value) {
    _id = value;
  }
}

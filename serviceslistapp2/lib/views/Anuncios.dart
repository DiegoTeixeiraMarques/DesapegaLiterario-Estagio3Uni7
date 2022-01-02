import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serviceslistapp2/models/Anuncio.dart';
import 'package:serviceslistapp2/util/Configuracoes.dart';
import 'package:serviceslistapp2/views/widgets/ItemAnuncio.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];
  List<DropdownMenuItem<String>> _listaItensDropCategorias;
  List<DropdownMenuItem<String>> _listaItensDropEstados;

  final _controler = StreamController<QuerySnapshot>.broadcast();

  String _itemSelecionadoEstado;
  String _itemSelecionadoCategoria;
  String _pesquisa;
  final TextEditingController _controllerText = TextEditingController();

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushNamed(context, "/login");
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Meus anúncios", "Deslogar"];
    }
  }

  _carregarItensDropdown() {
    //Categorias
    _listaItensDropCategorias = Configuracoes.getCategorias();

    //Estados
    _listaItensDropEstados = Configuracoes.getEstados();
  }

  // ignore: missing_return
  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db.collection("anuncios").snapshots();

    stream.listen((dados) {
      _controler.add(dados);
    });
  }

  // ignore: missing_return
  Future<Stream<QuerySnapshot>> _filtrarAnuncios(String text) async {
    Firestore db = Firestore.instance;
    Query query = db.collection("anuncios");

    if (_itemSelecionadoEstado != null) {
      query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
    }
    if (_itemSelecionadoCategoria != null) {
      query = query.where("categoria", isEqualTo: _itemSelecionadoCategoria);
    }
    if (_pesquisa != null && _pesquisa != "") {
      // Aqui
      query = query.where("isbn", whereIn: [_pesquisa]);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controler.add(dados);
    });
  }

  @override
  void initState() {
    super.initState();

    _carregarItensDropdown();
    _verificarUsuarioLogado();
    _adicionarListenerAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando anúncios"),
          CircularProgressIndicator()
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        //leading: Icon(Icons.menu),
        title: Text("Desapega Literário"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
        backgroundColor: Color(0xFF6D96E3),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //Aqui
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Expanded(
                  child: TextFormField(
                    //maxLength: 13,
                    controller: _controllerText,
                    decoration: InputDecoration(
                      hintText: "  Pesquisar pelo ISBN",
                      prefixIcon: Icon(Icons.search),
                      //border: OutlineInputBorder(
                      //borderRadius:
                      //BorderRadius.all(Radius.circular(10.0)))
                    ),
                    onChanged: (text) {
                      setState(() {
                        _pesquisa = text;
                        _filtrarAnuncios(text);
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: Center(
                    child: DropdownButton(
                      //iconEnabledColor: temaPadrao.primaryColor,
                      value: _itemSelecionadoEstado,
                      items: _listaItensDropEstados,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      onChanged: (estado) {
                        setState(() {
                          _itemSelecionadoEstado = estado;
                          _filtrarAnuncios(estado);
                        });
                      },
                    ),
                  )),
                ),
                Container(
                  color: Colors.grey[200],
                  width: 2,
                  height: 60,
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: Center(
                    child: DropdownButton(
                      //iconEnabledColor: Color(0xff9c27b0),
                      value: _itemSelecionadoCategoria,
                      items: _listaItensDropCategorias,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      onChanged: (categoria) {
                        setState(() {
                          _itemSelecionadoCategoria = categoria;
                          _filtrarAnuncios(categoria);
                        });
                      },
                    ),
                  )),
                )
              ],
            ),
            StreamBuilder(
              stream: _controler.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return carregandoDados;
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    QuerySnapshot querySnapshot = snapshot.data;

                    if (querySnapshot.documents.length == 0) {
                      return Container(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          "Nenhum anúncio! :( ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: querySnapshot.documents.length,
                          itemBuilder: (_, indice) {
                            List<DocumentSnapshot> anuncios =
                                querySnapshot.documents.toList();
                            DocumentSnapshot documentSnapshot =
                                anuncios[indice];
                            Anuncio anuncio =
                                Anuncio.fromDocumentSnapshot(documentSnapshot);

                            return ItemAnuncio(
                              anuncio: anuncio,
                              onTapItem: () {
                                Navigator.pushNamed(
                                    context, "/detalhes-anuncio",
                                    arguments: anuncio);
                              },
                            );
                          }),
                    );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

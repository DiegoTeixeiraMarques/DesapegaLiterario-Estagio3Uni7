import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serviceslistapp2/views/Anuncios.dart';
import 'package:serviceslistapp2/views/DetalhesAnuncio.dart';
import 'package:serviceslistapp2/views/Login.dart';
import 'package:serviceslistapp2/views/MeusAnuncios.dart';
import 'package:serviceslistapp2/views/NovoAnuncio.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Anuncios());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/meus-anuncios":
        return MaterialPageRoute(builder: (_) => MeusAnuncios());
      case "/novo-anuncio":
        return MaterialPageRoute(builder: (_) => NovoAnuncio());
      case "/detalhes-anuncio":
        return MaterialPageRoute(builder: (_) => DetalhesAnuncio(args));
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada!"),
        ),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configuracoes {
  static List<DropdownMenuItem<String>> getEstados() {
    List<DropdownMenuItem<String>> listaItensDropEstados = [];

    //Categorias
    listaItensDropEstados.add(DropdownMenuItem(
      child: Text(
        "Região",
        style: TextStyle(color: Color(0xff0E0F07)),
      ),
      value: null,
    ));

    for (var estado in Estados.listaEstadosAbrv) {
      listaItensDropEstados.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    }

    return listaItensDropEstados;
  }

  static List<DropdownMenuItem<String>> getCategorias() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Categorias
    itensDropCategorias.add(DropdownMenuItem(
      child: Text(
        "Categoria",
        style: TextStyle(color: Color(0xff0E0F07)),
      ),
      value: null,
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Romance"),
      value: "romance",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Drama "),
      value: "drama",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Fantasia"),
      value: "fantasia",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Misterio"),
      value: "misterio",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Científico"),
      value: "cientifico",
    ));
    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Terror"),
      value: "terror",
    ));

    return itensDropCategorias;
  }
}

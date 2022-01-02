import 'package:flutter/material.dart';
import 'package:serviceslistapp2/RouteGenerator.dart';
import 'package:serviceslistapp2/views/Anuncios.dart';

final ThemeData temaPadrao = ThemeData(primaryColor: Color(0xFF7BA4E3));

void main() => runApp(MaterialApp(
      title: "Desapega Literario",
      home: Anuncios(),
      theme: temaPadrao,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ));

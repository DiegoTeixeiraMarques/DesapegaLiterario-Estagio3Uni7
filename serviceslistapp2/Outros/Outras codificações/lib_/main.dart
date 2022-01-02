import 'package:flutter/material.dart';
import 'package:serviceslistapp2/RouteGenerator.dart';
import 'package:serviceslistapp2/views/Anuncios.dart';

final ThemeData temaPadrao = ThemeData(primaryColor: Color(0xff9c27b0));

void main() => runApp(MaterialApp(
      title: "OLX",
      home: Anuncios(),
      theme: temaPadrao,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ));


/* -- Solucao para falha na craga da imagem do firestore
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main(){
    HttpOverrides.global = new MyHttpOverrides();
    runApp(new MyApp());
*/
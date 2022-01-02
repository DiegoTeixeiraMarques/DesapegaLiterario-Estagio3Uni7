// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:serviceslistapp2/models/Anuncio.dart';

// ignore: must_be_immutable
class ItemAnuncio extends StatelessWidget {
  Anuncio anuncio;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;

  ItemAnuncio({@required this.anuncio, this.onTapItem, this.onPressedRemover});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 120,
                child: anuncio.fotos.length > 0
                    ? Image.network(
                        anuncio.fotos[0],
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/images/default.png"),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        anuncio.titulo,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Text(
                        "R\$ ${anuncio.preco} ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1),
                        child: Divider(),
                      ),
                      Container(
                        //color: Colors.grey[200],
                        alignment: Alignment.centerLeft,
                        //margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        child: Text(
                          "Categoria: ${anuncio.categoria} ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      Container(
                        //color: Colors.grey[200],
                        alignment: Alignment.centerLeft,
                        //margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        child: Text(
                          "ISBN: ${anuncio.isbn} ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      Container(
                        //color: Colors.grey[200],
                        alignment: Alignment.centerLeft,
                        //margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        child: Text(
                          "Contato: ${anuncio.telefone} ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ignore: sdk_version_ui_as_code
              if (this.onPressedRemover != null)
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        //color: Colors.red,
                        //padding: EdgeInsets.all(2),
                        onPressed: this.onPressedRemover,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),

              //botao remover
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:serviceslistapp2/components/messages.dart';
//import 'package:serviceslistapp2/components/new_message.dart';
import 'package:serviceslistapp2/core/services/auth/auth_service.dart';
//import 'package:serviceslistapp2/core/services/notification/chat_notification_service.dart';
//import 'package:serviceslistapp2/pages/notification_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const _defaultImage = 'assets/images/avatar.png';

  Widget _showUserImage(String imageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    if (uri.path.contains(_defaultImage)) {
      provider = AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      maxRadius: 80,
      backgroundColor: Colors.pink,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app, color: Colors.black87),
                          SizedBox(width: 10),
                          Text('Sair')
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                }),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _showUserImage(currentUser!.imageURL),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(currentUser.name,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentUser.email,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(65.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tram_sharp,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Cadastrar serviços')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

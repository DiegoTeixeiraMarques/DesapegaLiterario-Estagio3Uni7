import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:serviceslistapp2/core/models/chat_user.dart';
import 'package:serviceslistapp2/core/services/auth/auth_service.dart';
import 'package:serviceslistapp2/pages/auth_page.dart';
//import 'package:serviceslistapp2/pages/chat_page.dart';
import 'package:serviceslistapp2/pages/loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serviceslistapp2/pages/profile_page_estagio.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (cxt, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              } else {
                return snapshot.hasData ? ProfilePage() : AuthPage();
              }
            },
          );
        }
      },
    );
  }
}

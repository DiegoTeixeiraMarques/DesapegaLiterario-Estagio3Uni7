import 'package:flutter/material.dart';
import 'package:serviceslistapp2/components/auth_form.dart';
import 'package:serviceslistapp2/core/models/auth_form_data.dart';
import 'package:serviceslistapp2/core/services/auth/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        //Login
        await AuthService().login(
          formData.email,
          formData.password,
        );
      } else {
        //Signup
        await AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
      //Tratar o erro!
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: AuthForm(onSubmit: _handleSubmit),
              ),
            ),
            if (_isLoading)
              Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:peliculas/providers/auth_provider.dart';
import 'package:peliculas/utils/validators.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _txtEmailCtrl = TextEditingController();
  final _txtPassCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      key: _scaffKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Movie Store',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 40),
              Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              CustomTextField(
                txtCtrl: _txtEmailCtrl,
                label: 'Correo',
                validator: (value) => validateEmail(value!),
                iconData: Icons.email_outlined,
                enabled:
                    authProvider.loggedInStatus != AuthStatus.Authenticating,
              ),
              SizedBox(height: 5),
              CustomTextField(
                txtCtrl: _txtPassCtrl,
                label: 'Contraseña',
                validator: (value) => validateField(value!),
                iconData: Icons.lock_outlined,
                passwordField: true,
                enabled:
                    authProvider.loggedInStatus != AuthStatus.Authenticating,
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed:
                    authProvider.loggedInStatus == AuthStatus.Authenticating
                        ? null
                        : () => _doLogin(authProvider),
                child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child:
                        authProvider.loggedInStatus == AuthStatus.Authenticating
                            ? CircularProgressIndicator()
                            : Text('Iniciar sesión')),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed:
                      authProvider.loggedInStatus == AuthStatus.Authenticating
                          ? null
                          : () => Navigator.of(context).pushNamed('register'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text("Registrarse")))
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin(AuthProvider provider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, dynamic> response =
          await provider.login(_txtEmailCtrl.text, _txtPassCtrl.text);
      if (response['status']) {
        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      } else {
        ScaffoldMessenger.of(_scaffKey.currentContext!).showSnackBar(SnackBar(
            content: Text(response['message']),
            action: SnackBarAction(label: 'Ok', onPressed: () {})));
      }
    }
  }

  @override
  void dispose() {
    _txtEmailCtrl.dispose();
    _txtPassCtrl.dispose();
    super.dispose();
  }
}

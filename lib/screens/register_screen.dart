import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/providers/auth_provider.dart';
import 'package:peliculas/utils/validators.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _txtNameCtrl = TextEditingController();
  final _txtLastCtrl = TextEditingController();
  final _txtEmailCtrl = TextEditingController();
  final _txtPassCtrl = TextEditingController();
  final _txtConfirmPassCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        foregroundColor: Theme.of(context).iconTheme.color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Registro de usuario',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              CustomTextField(
                  txtCtrl: _txtNameCtrl,
                  label: 'Nombre',
                  validator: (value) => validateField(value!),
                  iconData: Icons.short_text_outlined,
                  enabled: authProvider.registeredInStatus !=
                      AuthStatus.Registering),
              SizedBox(height: 5),
              CustomTextField(
                  txtCtrl: _txtLastCtrl,
                  label: 'Apellido',
                  validator: (value) => validateField(value!),
                  iconData: Icons.short_text_outlined,
                  enabled: authProvider.registeredInStatus !=
                      AuthStatus.Registering),
              SizedBox(height: 5),
              CustomTextField(
                  txtCtrl: _txtEmailCtrl,
                  label: 'Correo',
                  validator: (value) => validateEmail(value!),
                  iconData: Icons.mail_outline,
                  enabled: authProvider.registeredInStatus !=
                      AuthStatus.Registering),
              SizedBox(height: 5),
              CustomTextField(
                  txtCtrl: _txtPassCtrl,
                  label: 'Contraseña',
                  passwordField: true,
                  validator: (value) => validateField(value!),
                  iconData: Icons.password_rounded,
                  enabled: authProvider.registeredInStatus !=
                      AuthStatus.Registering),
              SizedBox(height: 5),
              CustomTextField(
                  txtCtrl: _txtConfirmPassCtrl,
                  label: 'Confirmar contraseña',
                  passwordField: true,
                  validator: (value) => validateField(value!),
                  iconData: Icons.lock_outline,
                  enabled: authProvider.registeredInStatus !=
                      AuthStatus.Registering),
              SizedBox(height: 5),
              ElevatedButton(
                  onPressed:
                      authProvider.registeredInStatus == AuthStatus.Registering
                          ? null
                          : () => doRegistration(authProvider),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: authProvider.registeredInStatus ==
                              AuthStatus.Registering
                          ? CircularProgressIndicator()
                          : Text('Registrarse')))
            ],
          ),
        ),
      ),
    );
  }

  void doRegistration(AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_txtPassCtrl.text == _txtConfirmPassCtrl.text) {
        Map<String, dynamic> response = await authProvider.registerNewUser(
            _txtNameCtrl.text,
            _txtLastCtrl.text,
            _txtEmailCtrl.text,
            _txtPassCtrl.text);
        if (response['status']) {
          _showDialog(context);
        } else {
          ScaffoldMessenger.of(_scaffKey.currentContext!).showSnackBar(SnackBar(
              content: Text(response['message']),
              action: SnackBarAction(label: 'Ok', onPressed: () {})));
        }
      } else {
        ScaffoldMessenger.of(_scaffKey.currentContext!).showSnackBar(SnackBar(
            content: Text('Las contraseñas no coinciden bro'),
            action: SnackBarAction(label: 'Ok', onPressed: () {})));
      }
    }
  }

  _showDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text('¡Registro exitoso!'),
              content: Text("El usuario ha sido registrado."),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop('dialog');
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  void dispose() {
    _txtNameCtrl.dispose();
    _txtLastCtrl.dispose();
    _txtEmailCtrl.dispose();
    _txtPassCtrl.dispose();
    _txtConfirmPassCtrl.dispose();
    super.dispose();
  }
}

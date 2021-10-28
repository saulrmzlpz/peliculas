String? validateEmail(String value) {
  String? _msg;
  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value.isEmpty) {
    _msg = "El correo es requerido";
  } else if (!regex.hasMatch(value)) {
    _msg = "Escribe un correo válido";
  }
  return _msg;
}

String? validateField(String value) {
  String? _msg;
  ;
  if (value.trim().isEmpty) {
    _msg = "Este campo es requerido";
  }
  return _msg;
}

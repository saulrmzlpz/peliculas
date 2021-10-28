import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required TextEditingController txtCtrl,
    required String label,
    required IconData iconData,
    String? Function(String?)? validator,
    bool enabled = true,
    bool passwordField = false,
  })  : _txtCtrl = txtCtrl,
        _label = label,
        _iconData = iconData,
        _passwordField = passwordField,
        _validator = validator,
        _enabled = enabled,
        super(key: key);

  final TextEditingController _txtCtrl;
  final String _label;
  final IconData _iconData;
  final bool _passwordField, _enabled;
  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validator,
      enabled: _enabled,
      obscureText: _passwordField,
      decoration: InputDecoration(
          helperText: '',
          label: Text(_label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(_iconData)),
      controller: _txtCtrl,
    );
  }
}

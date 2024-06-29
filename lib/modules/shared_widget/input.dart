import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final Function(String?) onSaved;

  const Input({
    Key? key,
    required this.controller,
    required this.onSaved,
    required this.hintText,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style:
          Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xff34A853), width: 1.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}

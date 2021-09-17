import 'package:flutter/material.dart';

class CustomDateField extends TextField {
  final TextEditingController controller;
  final String text;
  CustomDateField(this.controller, this.text)
      : super(
            enabled: false,
            controller: controller,
            decoration: InputDecoration(
                labelText: text,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  width: 2,
                ))));
}

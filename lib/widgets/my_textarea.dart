import 'package:flutter/material.dart';

class MyTextArea extends StatelessWidget {
  const MyTextArea({
    Key? key,
    required this.value,
    required this.labelText,
    this.onChanged,
    this.validator,
    this.maxLines,
  }) : super(key: key);

  final dynamic value;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        enableSuggestions: false,
        autocorrect: false,
        maxLines: maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
            color: Colors.grey,
          ),
          suffix: const SizedBox(height: 20),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade600),
          ),
          counterText: '',
        ),
        validator: validator,
        initialValue: value,
      ),
    );
  }
}

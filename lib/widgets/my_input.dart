import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {

  final dynamic value;
  final String labelText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final int? maxLength;
  final FormFieldValidator<String>? validator;

  const MyInput({
    super.key, 
    required this.value,
    required this.labelText,
    required this.keyboardType,
    required this.onChanged,
    this.maxLength,
    this.validator,
  }) ;

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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        onChanged: onChanged,
        maxLength: maxLength,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
            color: Colors.grey[600],
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
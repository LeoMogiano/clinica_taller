import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final String welcomeText;
  final String name;

  const Welcome({
    super.key,
    required this.welcomeText,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
      child: Column(
        children: [
          Text(welcomeText,
            style: const TextStyle(
              fontSize: 21.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(name,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

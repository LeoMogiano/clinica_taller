import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/check');
    });
    
    return const Scaffold(
      backgroundColor:Color.fromARGB(255,255,255,255),
      body: Center(
        child:Image(
          image: AssetImage('assets/icon.png'),
          width: 130, // Ajusta el ancho según tus necesidades
        ),
      )
    );
  } 
}
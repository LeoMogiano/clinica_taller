import 'package:flutter/material.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:provider/provider.dart';


class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.checkAuth(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                Future.microtask(() async {
                  final user = await authService.readUser();
                  print(user.name);
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(name: user.name),
                      ),
                      (route) => false,
                    );
                  }
                });
                return Container();
              } else {
                return const LoginScreen();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

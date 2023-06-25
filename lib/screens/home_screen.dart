import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.user;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NavBar(
              icon: Icons.exit_to_app,
              isHome: true,
              onPressed: () async {
                await authService.logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                }
              },
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Welcome(
                        welcomeText: 'Bienvenido(a)',
                        name: name ?? user!.name,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonHome(
                              title: "Personal Médico",
                              imagePath: 'assets/medico.jpg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const UserScreen(
                                      title: 'LISTA DE PERSONAL MÉDICO',
                                      paciente: false,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 18.0),
                            ButtonHome(
                              title: "Pacientes",
                              imagePath: 'assets/paciente.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const UserScreen(
                                      title: 'LISTA DE PACIENTES',
                                      paciente: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonHome(
                              title: "Emergencias",
                              imagePath: 'assets/emergencia.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const EmergencyScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 18.0),
                            const ButtonHome(
                              title: "Detección Facial",
                              imagePath: 'assets/ident.png',
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: ButtonHome(
                            title: "Historias Médicas",
                            imagePath: 'assets/history.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 120.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

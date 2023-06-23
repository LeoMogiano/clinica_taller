import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.name}) ;

  final String? name;

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final userService = context.read<UserService>();
    final user = authService.user;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: ListView(
              children: [
                NavBar(
                  icon: Icons.exit_to_app,
                  isHome: true,
                  onPressed: () async {
                    await authService.logout();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Welcome(
                          welcomeText: 'Bienvenido(a)',
                          name: name ?? user!.name,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonHome(
                              title: "Personal Médico",
                              imagePath: 'assets/medico.jpg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => UserScreen(
                                      title: 'LISTA DE PERSONAL MÉDICO',
                                      getInfo: userService.getPersonalMed(),
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
                                    builder: (context) => UserScreen(
                                      title: 'LISTA DE PACIENTES',
                                      getInfo: userService.getPacientes(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
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
                        const SizedBox(
                          height: 25.0,
                        ),
                        const Center(
                          child: ButtonHome(
                            title: "Historias Médicas",
                            imagePath: 'assets/history.png',
                          ),
                        ),
                        const SizedBox(height: 120.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

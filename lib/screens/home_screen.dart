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
    var size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    /* final emergencyService = Provider.of<EmergencyService>(context, listen: false); */
    final user = authService.user;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Welcome(
                            welcomeText: 'Bienvenido(a)',
                            name: name ?? user!.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonHome(
                              title: "Personal Médico",
                              imagePath: 'assets/medico.jpg',
                              width: (size.width - 50) / 2,
                              height: 170,
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
                              width: (size.width - 50) / 2,
                              height: 170,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => UserScreen(
                                        title: 'LISTA DE PACIENTES',
                                        getInfo: userService.getPacientes()),
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
                              width: (size.width - 50) / 2,
                              height: 170,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>  EmergencyScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 18.0),
                            ButtonHome(
                              title: "Face ID",
                              imagePath: 'assets/ident.png',
                              width: (size.width - 50) / 2,
                              height: 170,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Center(
                          child:
                            ButtonHome(
                              title: "Historias Médicas",
                              imagePath: 'assets/history.png',
                              width: (size.width - 50) / 2,
                              height: 170,
                            ),
                            
                        ),
                        
                        const SizedBox(height: 120.0),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

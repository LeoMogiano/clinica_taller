import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({
    Key? key,
    this.title,
    required this.paciente,
  }) : super(key: key);

  final String? title;
  final bool paciente;

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[700],
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CreatePScreen(
                paciente: paciente,
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                NavBar(
                  isHome: false,
                  icon: Icons.arrow_back,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                (userService.isLoading)
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        height: MediaQuery.of(context).size.height - 90,
                        child: const Align(
                          alignment: Alignment.center,
                          child: CupertinoActivityIndicator(
                            color: Color(0xFF05539A),
                            radius: 20,
                            
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: paciente
                              ? ListView.builder(
                                  itemCount: userService.pacientes.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 18.0,
                                        ),
                                        child: Text(
                                          title ?? 'Usuarios',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    } else {
                                      final user =
                                          userService.pacientes[index - 1];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: ProfileCard(user: user),
                                      );
                                    }
                                  },
                                )
                              : ListView.builder(
                                  itemCount: userService.personalMed.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 18.0,
                                        ),
                                        child: Text(
                                          title ?? 'Usuarios',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    } else {
                                      final user =
                                          userService.personalMed[index - 1];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: ProfileCard(user: user),
                                      );
                                    }
                                  },
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

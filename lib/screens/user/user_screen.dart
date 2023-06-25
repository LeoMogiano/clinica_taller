import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/models/models.dart';
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
    final userService = Provider.of<UserService>(context);
    print('Hola');

    if (userService.isLoading) {
      return const Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[700] ,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CreatePScreen(
                title: 'REGISTRO DE USUARIO',
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
                Expanded(
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
                                final user = userService.pacientes[index - 1];
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
                                final user = userService.personalMed[index - 1];
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

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key, // Cambia "super.key" por "Key? key"
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  child: ClipRRect(
                    key: user.foto != null ? Key(user.id.toString()) : null,
                    borderRadius: BorderRadius.circular(175.0),
                    child: user.foto != null
                        ? Image.network(
                            user.foto!,
                            width: 275.0,
                            height: 275.0,
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage('assets/bale.jpg'),
                            width: 275.0,
                            height: 275.0,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            );
          },
          child: ClipRRect(
            key: user.foto != null ? Key(user.id.toString()) : null,
            borderRadius: BorderRadius.circular(25.0),
            child: user.foto != null
                ? Image.network(
                    user.foto!,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )
                : const Image(
                    image: AssetImage('assets/bale.jpg'),
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => EditPScreen(
                            title: 'ACTUALIZACIÓN DE DATOS',
                            user: user,
                            paciente: false,
                            edit: true,
                          )),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PerfilScreen(
                      user: user,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

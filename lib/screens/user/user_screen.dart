import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, this.title, required this.getInfo});

  final String? title;
  final Future<List<User>> getInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: FutureBuilder<List<User>>(
                      future: getInfo,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error al cargar los usuarios'),
                          );
                        } else {
                          final userList = snapshot.data;
                          if (userList != null && userList.isNotEmpty) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18.0,
                                    ),
                                    child: Text(
                                      title ?? 'Usuarios',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: userList.length,
                                    itemBuilder: (context, index) {
                                      final user = userList[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: ProfileCard(user: user),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              color: Colors.grey[200],
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'No se encontraron usuarios',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
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
    super.key,
    required this.user,
  });

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
                    borderRadius: BorderRadius.circular(175.0),
                    child: Image.asset(
                      'assets/bale.jpg',
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
            borderRadius: BorderRadius.circular(25.0),
            child: Image.asset(
              'assets/bale.jpg',
              width: 50.0,
              height: 50.0,
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
                // Acción para editar el elemento
              },
            ),
            IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PerfilScreen(user: user,),
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

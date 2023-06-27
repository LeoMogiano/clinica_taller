import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key, 
    required this.user,
    
  }) ;

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
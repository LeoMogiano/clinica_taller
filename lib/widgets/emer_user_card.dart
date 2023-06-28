import 'package:clinica_app_taller/models/models.dart';
import 'package:flutter/material.dart';

class EmerUserCard extends StatelessWidget {
  const EmerUserCard({
    super.key,
    required this.user,
    required this.trailing, required this.texto,
  });

  final User user;
  final String texto;
  final String trailing;

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
                  child: user.foto != null
                      ? ClipRRect(
                          key: Key(user.id.toString()),
                          borderRadius: BorderRadius.circular(175.0),
                          child: Image.network(
                            user.foto!,
                            width: 275.0,
                            height: 275.0,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(175.0),
                          ),
                          child: Image(
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
            borderRadius: BorderRadius.circular(25.0),
            child: Image(
              image: user.foto != null
                  ? NetworkImage(user.foto!) as ImageProvider
                  : const AssetImage('assets/bale.jpg'),
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(texto),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                trailing,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color.fromARGB(255, 91, 90, 90),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

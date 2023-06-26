
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emergencyService =
        Provider.of<EmergencyService>(context, listen: true);

    if (emergencyService.isLoading == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 18.0,
                              ),
                              child: Text(
                                'LISTA DE EMERGENCIAS',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: emergencyService.emergencies.length,
                              itemBuilder: (BuildContext context, int index) {
                                final emergency =
                                    emergencyService.emergencies[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: EmergencyCard(emergency: emergency),
                                );
                              },
                            ),
                          ],
                        ),
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
}

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    Key? key,
    required this.emergency,
  }) : super(key: key);

  final Emergency emergency;

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${emergency.fecha.day}/${emergency.fecha.month}/${emergency.fecha.year}';
    final formattedTime =
        '${emergency.hora.hour.toString().padLeft(2, '0')}:${emergency.hora.minute.toString().padLeft(2, '0')}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 10.0,
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Emergencia #${emergency.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0), // Ajustar el espaciado vertical
              Text(
                'Paciente: ${emergency.nameUser}',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estado: ${emergency.estado}'),
              Text('Fecha: $formattedDate - $formattedTime'),
            ],
          ),
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
                  // Acción para ver el elemento
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ShowEmergencyScreen(
                        emergency: emergency,
                      ),
                    ),
                  );
                
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
/* import 'package:flutter/cupertino.dart'; */
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/models/models.dart';
/* import 'package:clinica_app_taller/screens/screens.dart'; */
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';


class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    final emergencyService = Provider.of<EmergencyService>(context, listen: false);
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
                    child: FutureBuilder<List<Emergency>>(
                      future: emergencyService.getEmergencies(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error al cargar las emergencias'),
                          );
                        } else {
                          final emergencyList = snapshot.data;
                          if (emergencyList != null && emergencyList.isNotEmpty) {
                            return SingleChildScrollView(
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
                                    itemCount: emergencyList.length,
                                    itemBuilder: (context, index) {
                                      final emergency = emergencyList[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: EmergencyCard(emergency: emergency),
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
                                  'No se encontraron emergencias',
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

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    Key? key,
    required this.emergency,
  }) : super(key: key);

  final Emergency emergency;

  @override
  Widget build(BuildContext context) {
    final formattedDate = '${emergency.fecha.day}/${emergency.fecha.month}/${emergency.fecha.year}';
    final formattedTime = '${emergency.hora.hour.toString().padLeft(2, '0')}:${emergency.hora.minute.toString().padLeft(2, '0')}';

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
                  // Acción para ver detalles de la emergencia
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

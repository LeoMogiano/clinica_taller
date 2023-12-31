import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emergencyService = Provider.of<EmergencyService>(context, listen: true);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[700],
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CreateEScreen(
                emergencyService: emergencyService,
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
                  child: emergencyService.isLoading
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: CupertinoActivityIndicator(
                              color: Color(0xFF05539A),
                              radius: 20,
                            ),
                          ),
                        )
                      : Column(
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
                            Expanded(
                              child: ListView.builder(
                                itemCount: emergencyService.emergencies.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final emergency = emergencyService.emergencies[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: EmergencyCard(
                                      emergency: emergency,
                                      emergencyService: emergencyService,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 30.0), // A spacer to push content down
                          ],
                        ),
                ),
              ),
            ],
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
    required this.emergencyService,
  }) : super(key: key);

  final Emergency emergency;
  final EmergencyService emergencyService;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(emergency.fecha);
    final formattedTime =
        TimeOfDay(hour: emergency.hora.hour, minute: emergency.hora.minute)
            .format(context);

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
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => EditEScreen(
                            emergencyService: emergencyService,
                            emergency: emergency)),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ShowEmergencyScreen(
                              emergency: emergency,
                              emergencyService: emergencyService,
                            )),
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

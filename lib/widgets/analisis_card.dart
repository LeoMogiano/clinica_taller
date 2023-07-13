import 'package:clinica_app_taller/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalisisCard extends StatelessWidget {
  const AnalisisCard({
    Key? key,
    required this.analisis,
  }) : super(key: key);

  final Analisis analisis;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(analisis.fecha);
    final formattedTime =
        TimeOfDay(hour: analisis.hora.hour, minute: analisis.hora.minute)
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
                'Analisis #${analisis.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0), // Ajustar el espaciado vertical
              Text(
                analisis.descripcion,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0), // Ajustar el espaciado vertical
              Text(
                'Motivo: ${analisis.motivo}',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4.0), // Ajustar el espaciado vertical
              Text('Fecha: $formattedDate - $formattedTime',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
                color: Colors.grey,
              ),
              
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /* IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  /* Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => EditEScreen(
                            emergencyService: emergencyService,
                            emergency: emergency)),
                  ); */
                },
              ), */
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  /* Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ShowEmergencyScreen(
                              emergency: emergency,
                              emergencyService: emergencyService,
                            )),
                  ); */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

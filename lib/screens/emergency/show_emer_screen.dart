import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class ShowEmergencyScreen extends StatelessWidget {
  const ShowEmergencyScreen({
    super.key,
    required this.emergency,
    required this.emergencyService,
  });

  final Emergency emergency;
  final EmergencyService emergencyService;

  @override
  Widget build(BuildContext context) {
    const BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.white,
    );

    return Scaffold(
      body: Container(
        decoration: containerDecoration,
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
                  color: Colors.grey[200],
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    children: [
                      FutureBuilder<List<User>>(
                        future: emergencyService.loadMedicPac(
                          emergency.userId.toString(),
                          emergency.medicoId.toString(),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              heightFactor: 18.0,
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Error al cargar los datos de paciente y médico'),
                            );
                          } else {
                            final List<User> medicPac = snapshot.data!;
                            final User paciente = medicPac[0];
                            final User medico = medicPac[1];

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'EMERGENCIA #${emergency.id}',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                EmerUserCard(
                                  user: paciente,
                                  texto:
                                      '${paciente.sexo} - ${DateTime.now().difference(DateTime.parse(paciente.fechaNac!.toIso8601String())).inDays ~/ 365} años',
                                  trailing: 'Paciente',
                                ),
                                const SizedBox(height: 4.0),
                                EmerUserCard(
                                  user: medico,
                                  texto: '${medico.especialidad}',
                                  trailing: 'Médico',
                                ),
                                const SizedBox(height: 6.0),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Center(
                                          child: Text(
                                            'Información de Emergencia',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        _emergenciaInfoRow(
                                          label1: 'Estado',
                                          value1: emergency.estado,
                                          label2: 'Gravedad',
                                          value2: emergency.gravedad ?? 'Alta',
                                        ),
                                        const SizedBox(height: 8.0),
                                        _emergenciaInfoRow(
                                          label1: 'Fecha',
                                          value1: DateFormat('dd/MM/yyyy')
                                              .format(emergency.fecha),
                                          label2: 'Hora',
                                          value2: TimeOfDay(
                                                  hour: emergency.hora.hour,
                                                  minute: emergency.hora.minute)
                                              .format(context),
                                        ),
                                        const SizedBox(height: 8.0),
                                        _emergenciaInfo(
                                          label: 'Motivo',
                                          value: emergency.motivo ??
                                              'Dificultad para respirar y fiebre alta',
                                        ),
                                        if (emergency.observacion != null)
                                          const SizedBox(height: 8.0),
                                        _emergenciaInfo(
                                          label: 'Observación',
                                          value: emergency.observacion ??
                                              'El paciente presentaba dificultad para respirar, fiebre alta y tos persistente.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            emergency.diagnostico != null
                                                ? 'Diagnóstico Final'
                                                : 'DIAGNÓSTICO PENDIENTE',
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Center(
                                          child: Text(
                                            emergency.diagnostico ?? '',
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Lógica para crear el diagnóstico final
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.green[700]!,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Lógica para añadir información de análisis
                                      },
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30.0),
                              ],
                            );
                          }
                        },
                      ),
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

  Widget _emergenciaInfoRow({
    required String label1,
    required String value1,
    required String label2,
    required String value2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _emergenciaInfo(
              label: label1,
              value: value1,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: _emergenciaInfo(
              label: label2,
              value: value2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emergenciaInfo({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

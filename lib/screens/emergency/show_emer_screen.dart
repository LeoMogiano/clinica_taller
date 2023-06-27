import 'package:clinica_app_taller/widgets/emer_user_card.dart';
import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class ShowEmergencyScreen extends StatelessWidget {
  const ShowEmergencyScreen(
      {super.key,
      required this.emergency,
      required this.paciente,
      required this.medico});

  final Emergency emergency;
  final User paciente;
  final User medico;

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
                      const SizedBox(height: 8.0),
                      EmerUserCard(
                          user: medico,
                          texto: '${medico.especialidad} - Cel ${medico.telefono}',
                          trailing: 'Médico'),
                      const SizedBox(height: 8.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                value1: emergency.fecha.toIso8601String(),
                                label2: 'Hora',
                                value2: emergency.hora.toIso8601String(),
                              ),
                              const SizedBox(height: 8.0),
                              _emergenciaInfo(
                                  label: 'Motivo',
                                  value: emergency.motivo ??
                                      'Dificultad para respirar y fiebre alta'),
                              if (emergency.observacion != null)
                                const SizedBox(height: 8.0),
                              _emergenciaInfo(
                                  label: 'Observación',
                                  value: emergency.observacion ??
                                      'El paciente presentaba dificultad para respirar, fiebre alta y tos persistente.'),
                              if (emergency.diagnostico != null)
                                const SizedBox(height: 8.0),
                              Center(
                                child: _emergenciaInfo(
                                    label: 'Diagnóstico',
                                    value: emergency.diagnostico ?? 'Neumonía'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Detalle Final',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Text(
                                  'Se le diagnosticó con gastroenteritis aguda y se le brindó tratamiento con líquidos intravenosos y medicamentos para controlar los síntomas. Tras una mejoría significativa, se le dio de alta con instrucciones de cuidado en el hogar.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para crear el diagnóstico final
                              },
                              child: const Text('Crear Diagnóstico Final'),
                            ),
                            const SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para añadir información de análisis
                              },
                              child:
                                  const Text('Añadir Información de Análisis'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
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

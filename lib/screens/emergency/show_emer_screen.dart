import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class ShowEmergencyScreen extends StatelessWidget {
  const ShowEmergencyScreen({super.key, required this.emergency});

  final Emergency emergency;

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
                                label1: 'Fecha',
                                value1: emergency.fecha.toIso8601String(),
                                label2: 'Hora',
                                value2: emergency.hora.toIso8601String(),
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
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

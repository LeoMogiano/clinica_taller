import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class HistoriaScreen extends StatelessWidget {
  const HistoriaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.white,
    );
    final historiaService = Provider.of<HistoriaService>(context, listen: true);

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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      historiaService.isLoading
                          ? const SizedBox(height: 0)
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 18.0,
                              ),
                              child: Center(
                                child: Text(
                                  'HISTORIAS MÉDICAS',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                      historiaService.isLoading
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              height: MediaQuery.of(context).size.height - 180,
                              child: const Align(
                                alignment: Alignment.center,
                                child: CupertinoActivityIndicator(
                                  color: Color(0xFF05539A),
                                  radius: 20,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                itemCount: historiaService.historias.length,
                                itemBuilder: (context, index) {
                                  final historia =
                                      historiaService.historias[index];
                                  final paciente = historiaService.pacHistoria
                                      .firstWhere(
                                          (user) => user.id == historia.userId);

                                  return HistoriaCard(
                                    user: paciente,
                                    value:
                                        '${paciente.sexo} - ${DateTime.now().difference(DateTime.parse(paciente.fechaNac!.toIso8601String())).inDays ~/ 365} años', 
                                        historia: historia,
                                  );
                                },
                              ),
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

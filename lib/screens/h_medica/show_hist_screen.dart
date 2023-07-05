import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class ShowHScreen extends StatelessWidget {
  const ShowHScreen({super.key, required this.historia, required this.user});

  final HistoriaMedica historia;
  final User user;

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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 18.0,
                        ),
                        child: Center(
                          child: Text(
                            'HISTORIA MÉDICA',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: CircleAvatar(
                          key: Key(user.id.toString()),
                          radius: 100.0,
                          backgroundImage: user.foto != null
                              ? NetworkImage(user.foto!) as ImageProvider
                              : const AssetImage('assets/bale.jpg'),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 17.0,
                        ),
                        child: Center(
                          child: Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Información Personal',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfoRow(
                                label1: 'Edad',
                                value1: '${DateTime.now().difference(DateTime.parse(user.fechaNac!.toIso8601String())).inDays ~/ 365} años',
                                label2: 'Tipo de Sangre',
                                value2: user.tipoSangre ?? 'No especificado',
                              ),
                              _historiaInfoRow(
                                label1: 'Sexo',
                                value1: user.sexo ?? 'No especificado',
                                label2: 'Contac. Emergencia',
                                value2: user.contactoEmerg ?? 'No especificado',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Información de la Salud',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfo(
                                label: 'Alergias',
                                value: historia.alergias,
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfo(
                                label: 'Medicamentos',
                                value: historia.medisAct,
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfo(
                                label: 'Ultima Informacion',
                                value: historia.saludActual,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Antecedentes Médicos',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfo(
                                label: 'Familiares',
                                value: historia.antMedFam,
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfo(
                                label: 'Personales',
                                value: historia.antMedPers,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Historico',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfo(
                                label: 'Enfermedades',
                                value: historia.hEnfermedades,
                              ),
                              const SizedBox(height: 16.0),
                              _historiaInfo(
                                label: 'Cirugias',
                                value: historia.hCirugias,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Información Extra',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Center(
                                child: _historiaInfo(
                                  label: 'Notas',
                                  value: historia.notas,
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      /* Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Información Personal',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _personalInfoRow(
                                label1: 'Carnet de Identidad',
                                value1: user.carnet ?? 'No especificado',
                                label2: 'Fecha de Nacimiento',
                                value2: user.fechaNac != null
                                    ? DateFormat('dd/MM/yyyy').format(user.fechaNac!)
                                    : 'No especificada',
                              ),
                              _personalInfoRow(
                                label1: 'Teléfono',
                                value1: user.telefono ?? 'No especificado',
                                label2: 'Email',
                                value2: user.email,
                              ),
                              _personalInfoRow(
                                label1: 'Rol',
                                value1: user.role ?? 'No especificado',
                                label2: 'Grupo',
                                value2: user.group ?? 'No especificado',
                              ),
                              
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ), */
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

  Widget _historiaInfoRow({
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
            child: _historiaInfo(
              label: label1,
              value: value1,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: _historiaInfo(
              label: label2,
              value: value2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _historiaInfo({required String label, required String value}) {
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
        const SizedBox(height: 4.0),
      ],
    );
  }
}

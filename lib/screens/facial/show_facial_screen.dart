import 'package:clinica_app_taller/screens/facial/util_facial.dart';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';
import 'package:clinica_app_taller/services/services.dart';

class ShowFScreen extends StatelessWidget {
  const ShowFScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    const BoxDecoration containerDecoration = BoxDecoration(
      color: Colors.white,
    );

    return Consumer<FacialService>(
      builder: (context, facialService, _) {
        return FutureBuilder<HistoriaMedica>(
          future: facialService.getHistoriaByUser(user.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                    child: CupertinoActivityIndicator(
                  color: Color(0xFF05539A),
                )),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')),
              );
            } else {
              final historia = snapshot.data!;

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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                                        ? NetworkImage(user.foto!)
                                            as ImageProvider
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        historiaInfoRow(
                                          label1: 'Edad',
                                          value1:
                                              '${DateTime.now().difference(DateTime.parse(user.fechaNac!.toIso8601String())).inDays ~/ 365} años',
                                          label2: 'Tipo de Sangre',
                                          value2: user.tipoSangre ??
                                              'No especificado',
                                        ),
                                        historiaInfoRow(
                                          label1: 'Sexo',
                                          value1:
                                              user.sexo ?? 'No especificado',
                                          label2: 'Contac. Emergencia',
                                          value2: user.contactoEmerg ??
                                              'No especificado',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        historiaInfo(
                                          label: 'Alergias',
                                          value: historia.alergias,
                                        ),
                                        const SizedBox(height: 16.0),
                                        historiaInfo(
                                          label: 'Medicamentos',
                                          value: historia.medisAct,
                                        ),
                                        const SizedBox(height: 16.0),
                                        historiaInfo(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        historiaInfo(
                                          label: 'Familiares',
                                          value: historia.antMedFam,
                                        ),
                                        const SizedBox(height: 16.0),
                                        historiaInfo(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        historiaInfo(
                                          label: 'Enfermedades',
                                          value: historia.hEnfermedades,
                                        ),
                                        const SizedBox(height: 16.0),
                                        historiaInfo(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          child: historiaInfo(
                                            label: 'Notas',
                                            value: historia.notas,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFe11709),
                                          ),
                                          child: const Icon(
                                            Icons.emergency,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    const CheckAuthScreen()),
                                          );
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF085C9D),
                                          ),
                                          child: const Icon(
                                            Icons.home,
                                            color: Colors.white,
                                          ),
                                        ),
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
          },
        );
      },
    );
  }
}

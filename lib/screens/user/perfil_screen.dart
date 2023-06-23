import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key, this.user});

  final User? user;

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
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    children: [
                      const SizedBox(height: 22.0),
                      Center(
                        child: CircleAvatar(
                          key: Key(user?.id.toString() ?? ''),
                          radius: 100.0,
                          backgroundImage: user?.foto != null
                              ? NetworkImage(user!.foto!) as ImageProvider
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
                            user!.name,
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
                              _personalInfoRow(
                                label1: 'Carnet de Identidad',
                                value1: user!.carnet ?? 'No especificado',
                                label2: 'Fecha de Nacimiento',
                                value2: user!.fechaNac != null
                                    ? '${user!.fechaNac!.day}/${user!.fechaNac!.month}/${user!.fechaNac!.year}'
                                    : 'No especificada',
                              ),
                              _personalInfoRow(
                                label1: 'Teléfono',
                                value1: user!.telefono ?? 'No especificado',
                                label2: 'Email',
                                value2: user!.email,
                              ),
                              _personalInfoRow(
                                label1: 'Rol',
                                value1: user!.role ?? 'No especificado',
                                label2: 'Grupo',
                                value2: user!.group ?? 'No especificado',
                              ),
                              _personalInfoRow(
                                label1: 'Especialidad',
                                value1: user!.especialidad ?? 'No especificado',
                                label2: 'Tipo de Sangre',
                                value2: user!.tipoSangre ?? 'No especificado',
                              ),
                              _personalInfoRow(
                                label1: 'Contacto de Emergencia',
                                value1: user!.contactoEmerg ?? 'No especificado',
                                label2: 'Sexo',
                                value2: user!.sexo ?? 'No especificado',
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

  Widget _personalInfoRow({
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
            child: _personalInfo(
              label: label1,
              value: value1,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: _personalInfo(
              label: label2,
              value: value2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _personalInfo({required String label, required String value}) {
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

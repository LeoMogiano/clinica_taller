import 'package:clinica_app_taller/services/services.dart';
import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CreateEScreen extends StatelessWidget {
  const CreateEScreen({super.key, required this.emergencyService});
  final EmergencyService emergencyService;

  @override
  Widget build(BuildContext context) {
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
                  icon: Icons.close,
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 18.0,
                      ),
                      children:  [
                        const Text(
                          'Registro de Emergencia',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        _BuildForm(emergencyService)
                      ],
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

class _BuildForm extends StatefulWidget {
  const _BuildForm(this.emergencyService) ;

final EmergencyService emergencyService;
  @override
  State<_BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<_BuildForm> {
  final formKey = GlobalKey<FormState>();
 

  Emergency emergency = Emergency(
      estado: '',
      fecha: DateTime(1990),
      hora: const TimeOfDay(hour: 0, minute: 0),
      userId: 9,
      medicoId: 1);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);
    
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextArea(
            labelText: 'Motivo',
            maxLines: null,
            onChanged: (value) {
              setState(() {
                emergency.motivo = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null;
            },
            value: emergency.motivo,
          ),
          const SizedBox(
            height: 10,
          ),
          MyDropdown<String>(
            labelText: 'Gravedad',
            items: const [
              DropdownMenuItem<String>(
                value: 'Baja',
                child: Text('Baja'),
              ),
              DropdownMenuItem<String>(
                value: 'Media',
                child: Text('Media'),
              ),
              DropdownMenuItem<String>(
                value: 'Alta',
                child: Text('Alta'),
              ),
            ],
            value: emergency.gravedad,
            onChanged: (value) {
              setState(() {
                emergency.gravedad = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MyDateField(
            labelText: 'Fecha de Emergencia',
            selectedDate: emergency.fecha,
            onChanged: (value) {
              setState(() {
                emergency.fecha = value!;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Este campo es requerido';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MyTimeField(
            labelText: 'Hora',
            selectedTime: emergency.hora,
            onChanged: (value) {
              setState(() {
                emergency.hora = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextArea(
            labelText: 'Observación',
            maxLines: null,
            onChanged: (value) {
              setState(() {
                emergency.observacion = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null; // Sin errores de validación
            },
            value: emergency.observacion,
          ),
          const SizedBox(height: 10),
           MyDropdown<int>(
            labelText: 'Selecciona un paciente',
            items: _buildDropdownItems(userService.pacientes),
            value: emergency.userId,
            onChanged: (int? userId) {
              emergency.userId = userId!;
            },
          ),
          const SizedBox(height: 10),
           MyDropdown<int>(
            labelText: 'Selecciona un médico',
            items: _buildDropdownItems(userService.personalMed),
            value: emergency.medicoId,
            onChanged: (int? userId) {
             emergency.medicoId = userId!;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              emergency.estado = 'En atención';
              emergency.diagnostico = '';
              emergency.nameUser = userService.pacientes.firstWhere((element) => element.id == emergency.userId).name;
              emergency.id = await widget.emergencyService.getEmergencies().then((value) => value.length + 1);
              if (formKey.currentState!.validate() && !widget.emergencyService.isLoading) {
                await widget.emergencyService.createEmergencia(emergency);
              }
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar cambios'),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<int>> _buildDropdownItems(List<User> users) {
  Set<int> uniqueIds =
      {}; // Utilizamos un conjunto para almacenar los IDs únicos
  List<DropdownMenuItem<int>> items = [];

  for (User user in users) {
    if (!uniqueIds.contains(user.id)) {
      uniqueIds.add(user.id!);
      items.add(
        DropdownMenuItem<int>(
          value: user.id,
          child: Text(user.name),
        ),
      );
    }
  }

  return items;
}

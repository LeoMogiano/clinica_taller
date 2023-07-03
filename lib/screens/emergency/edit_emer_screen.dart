import 'package:clinica_app_taller/services/services.dart';
import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditEScreen extends StatelessWidget {
  const EditEScreen({ super.key, required this.emergencyService, required this.emergency});
  final EmergencyService emergencyService;
  final Emergency emergency;
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
                      children: [
                        const Text(
                          'ACTUALIZACIÓN DE DATOS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        _BuildForm(emergencyService,emergency),
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
  const _BuildForm(this.emergencyService, this.emergency);

  final EmergencyService emergencyService;
  final Emergency emergency;

  @override
  State<_BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<_BuildForm> {
  final formKey = GlobalKey<FormState>();


  bool isSubmitted = false;

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
                widget.emergency.motivo = value;
              });
            },
            validator: (value) {
              if (isSubmitted && (value == null || value.isEmpty)) {
                return 'Este campo es requerido';
              }
              return null;
            },
            value: widget.emergency.motivo,
          ),
          const SizedBox(height: 10),
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
            value: widget.emergency.gravedad,
            validator: (value) {
              if (isSubmitted && value == null) {
                return 'Este campo es requerido';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                widget.emergency.gravedad = value;
              });
            },
          ),
          const SizedBox(height: 10),
          MyDateField(
            labelText: 'Fecha de Emergencia',
            selectedDate: widget.emergency.fecha,
            onChanged: (value) {
              setState(() {
                widget.emergency.fecha = value!;
              });
            },
            validator: (value) {
              if (isSubmitted && value == null) {
                return 'Este campo es requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          MyTimeField(
            labelText: 'Hora',
            selectedTime: widget.emergency.hora,
            onChanged: (value) {
              setState(() {
                widget.emergency.hora = value!;
              });
            },
          ),
          const SizedBox(height: 10),
          MyTextArea(
            labelText: 'Observación',
            maxLines: null,
            onChanged: (value) {
              setState(() {
                widget.emergency.observacion = value;
              });
            },
            validator: (value) {
              if (isSubmitted && (value == null || value.isEmpty)) {
                return 'Este campo es requerido';
              }
              return null;
            },
            value: widget.emergency.observacion,
          ),
          const SizedBox(height: 10),
          MyDropdown<int>(
            labelText: 'Selecciona un paciente',
            items: _buildDropdownItems(userService.pacientes),
            value: widget.emergency.userId,
            onChanged: (int? userId) {
              setState(() {
                widget.emergency.userId = userId!;
              });
            },
            validator: (value) {
              if (isSubmitted && value == null) {
                return 'Este campo es requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          MyDropdown<int>(
            labelText: 'Selecciona un médico',
            items: _buildDropdownItems(userService.personalMed),
            value: widget.emergency.medicoId,
            onChanged: (int? userId) {
              setState(() {
                widget.emergency.medicoId = userId!;
              });
            },
            validator: (value) {
              if (isSubmitted && value == null) {
                return 'Este campo es requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isSubmitted = true;
              });

              if (formKey.currentState!.validate() && !widget.emergencyService.isLoading) {
                widget.emergency.estado = 'En atención';
                widget.emergency.diagnostico = '';
                widget.emergency.nameUser =
                    userService.pacientes.firstWhere((element) => element.id == widget.emergency.userId).name;
      
                await widget.emergencyService.updateEmergencia(widget.emergency.id.toString(), widget.emergency);
                if(context.mounted) {
                  Navigator.pop(context);
                }
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

import 'package:clinica_app_taller/services/services.dart';
import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class CreateAScreen extends StatelessWidget {
  const CreateAScreen(
      {Key? key, required this.emergencyService, required this.emergency})
      : super(key: key);
  final Emergency emergency;
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
                      children: [
                        const Text(
                          'Registro de Analisis',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        _BuildForm(emergencyService, emergency),
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
  final Emergency emergency;
  final EmergencyService emergencyService;

  @override
  State<_BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<_BuildForm> {
  final formKey = GlobalKey<FormState>();

  Analisis analisis = Analisis(
      descripcion: '',
      motivo: '',
      fecha: DateTime(2022),
      hora: const TimeOfDay(hour: 5, minute: 30),
      emergenciaId: 0);

  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextArea(
            labelText: 'Descripción',
            maxLines: null,
            onChanged: (value) {
              setState(() {
                analisis.descripcion = value;
              });
            },
            validator: (value) {
              if (isSubmitted && (value == null || value.isEmpty)) {
                return 'Este campo es requerido';
              }
              return null;
            },
            value: analisis.descripcion,
          ),
          const SizedBox(height: 10),
          MyTextArea(
            labelText: 'Motivo',
            maxLines: null,
            onChanged: (value) {
              setState(() {
                analisis.motivo = value;
              });
            },
            validator: (value) {
              if (isSubmitted && (value == null || value.isEmpty)) {
                return 'Este campo es requerido';
              }
              return null;
            },
            value: analisis.motivo,
          ),
          const SizedBox(height: 10),
          MyDateField(
            labelText: 'Fecha de Análisis',
            selectedDate: analisis.fecha,
            onChanged: (value) {
              setState(() {
                analisis.fecha = value!;
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
            selectedTime: analisis.hora,
            onChanged: (value) {
              setState(() {
                analisis.hora = value!;
              });
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isSubmitted = true;
              });

              if (formKey.currentState!.validate() &&
                  !widget.emergencyService.isLoading) {
                analisis.emergenciaId = widget.emergency.id!;
                analisis.id = await widget.emergencyService
                    .getAnalisisByEmergency(widget.emergency.id!)
                    .then((value) => value.length + 1);
                /* await widget.emergencyService.createEmergencia(emergency); */
                await widget.emergencyService.createAnalisis(analisis);
                if (context.mounted) {
                  Navigator.pop(context);
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

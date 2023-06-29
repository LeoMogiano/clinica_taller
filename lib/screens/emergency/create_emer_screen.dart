
import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class CreateEScreen extends StatelessWidget {
  const CreateEScreen({super.key});


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
                      children: const [
                        Text(
                          'Registro de Emergencia',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        _BuildForm()
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
  const _BuildForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<_BuildForm> {
  final formKey = GlobalKey<FormState>();
  final List<String> bloodTypes = [
    'O+',
    'O-',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-'
  ];
  
  Emergency emergency = Emergency(estado: '', fecha: DateTime(1990), hora: const TimeOfDay(hour: 0, minute: 0), userId: 9, medicoId: 1);
      
  @override
  Widget build(BuildContext context) {
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
              return null; // Sin errores de validación
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
                emergency.fecha =
                    value!; // Actualiza el nombre del usuario con el nuevo valor ingresado
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Este campo es requerido';
              }
              // Aquí puedes agregar una validación de formato de fecha si lo deseas
              return null; // Sin errores de validación
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
          ElevatedButton(
            onPressed: () async {
              /* if (formKey.currentState!.validate() && !userService.isLoading) {
                await userService.createUsuario(user, password, user.group!);
              }
              if (context.mounted) {
                Navigator.pop(context);
              } */
            },
            child: const Text('Guardar cambios'),
          ),
        ],
      ),
    );
  }
}

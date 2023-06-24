import 'package:flutter/material.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class CreatePScreen extends StatelessWidget {
  const CreatePScreen({super.key, this.title});

  final String? title;
  

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
                        Text(
                          title ?? 'Usuarios',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        BuildForm()
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

class BuildForm extends StatefulWidget {
  const BuildForm({
    super.key,

  });


  @override
  State<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    User user = User(name:'', email: '');
    return Form(
      child: Column(
        children: [
          
          MyInput(
            labelText: 'Nombre',
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                user.name = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null; // Sin errores de validación
            },
            value: user.name,
          ),
          const SizedBox(height: 10),
          MyInput(
            labelText: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                user.email = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su correo';
              }
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value) ? null : 'El correo no es válido';
            },
            value: user.email,
          ),
          const SizedBox(height: 10),
          MyDateField(
            labelText: 'Fecha de nacimiento',
            selectedDate: user.fechaNac,
            onChanged: (value) {
              setState(() {
                user.fechaNac = value; // Actualiza el nombre del usuario con el nuevo valor ingresado
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyInput(
                  labelText: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      user.telefono = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    // Aquí puedes agregar una validación de formato de teléfono si lo deseas
                    return null; // Sin errores de validación
                  },
                  value: user.telefono,
                ),
              ),
              const SizedBox(width: 2.5),
              Expanded(
                child: MyInput(
                  labelText: 'Carnet (ID)',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      user.carnet = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null; // Sin errores de validación
                  },
                  value: user.carnet,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          MyDropdown<String>(
            labelText: 'Grupo',
            items: const [
              DropdownMenuItem<String>(
                value: 'Pacientes',
                child: Text('Pacientes'),
              ),
              DropdownMenuItem<String>(
                value: 'Personal Médico',
                child: Text('Personal Médico'),
              ),
            ],
            value: user.group,
            onChanged: (value) {
              setState(() {
                user.group = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null; // Sin errores de validación
            },
          ),
          const SizedBox(height: 10),
          if (user.group == 'Pacientes')
            MyDropdown<String>(
              labelText: 'Rol',
              items: const [
                DropdownMenuItem<String>(
                  value: 'Asegurado',
                  child: Text('Asegurado'),
                ),
                DropdownMenuItem<String>(
                  value: 'No Asegurado',
                  child: Text('No Asegurado'),
                ),
              ],
              value: user.role,
              onChanged: (value) {
                setState(() {
                  user.role = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null; // Sin errores de validación
              },
            ),
          if (user.group == 'Personal Médico')
            MyDropdown<String>(
              labelText: 'Rol',
              items: const [
                DropdownMenuItem<String>(
                  value: 'Doctor',
                  child: Text('Doctor'),
                ),
                DropdownMenuItem<String>(
                  value: 'Enfermero',
                  child: Text('Enfermero'),
                ),
              ],
              value: user.role,
              onChanged: (value) {
                setState(() {
                  user.role = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null; // Sin errores de validación
              },
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: MyDropdown<String>(
                  labelText: 'Sexo',
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Masculino',
                      child: Text('Masculino'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Femenino',
                      child: Text('Femenino'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Otro',
                      child: Text('Otro'),
                    ),
                  ],
                  value: user.sexo,
                  onChanged: (value) {
                    setState(() {
                      user.sexo = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null; // Sin errores de validación
                  },
                ),
              ),
              const SizedBox(width: 2.5),
              Expanded(
                child: MyDropdown<String>(
                  labelText: 'Tipo Sangre',
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'O+',
                      child: Text('ORH +'),
                    ),
                    // Agrega aquí todos los tipos de sangre necesarios
                  ],
                  value: user.tipoSangre,
                  onChanged: (value) {
                    setState(() {
                      user.tipoSangre = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null; // Sin errores de validación
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // El formulario es válido, puedes realizar la acción deseada aquí
                // Por ejemplo, guardar los datos en la base de datos o enviarlos a través de una API
              }
            },
            child: const Text('Guardar'),
          ),
          // Agrega más campos de acuerdo al modelo User
        ],
      ),
    );
  }
}

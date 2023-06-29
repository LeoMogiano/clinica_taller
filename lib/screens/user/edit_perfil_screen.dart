import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class EditPScreen extends StatelessWidget {
  const EditPScreen({
    Key? key,
    this.title,
    required this.user,
    required this.paciente,
    required this.edit,
  }) : super(key: key);

  final String? title;
  final User user;
  final bool edit;
  final bool paciente;

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
                        _BuildForm(
                          user: user,
                          paciente: paciente,
                          edit: edit,
                        ),
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
    required this.user,
    required this.paciente,
    required this.edit,
  }) : super(key: key);

  final User user;
  final bool edit;
  final bool paciente;

  @override
  _BuildFormState createState() => _BuildFormState();
}

class _BuildFormState extends State<_BuildForm> {
  final formKey = GlobalKey<FormState>();
  final List<String> bloodTypes = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyInput(
            labelText: 'Nombre',
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                widget.user.name = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es requerido';
              }
              return null; // Sin errores de validación
            },
            value: widget.user.name,
          ),
          const SizedBox(height: 10),
          MyInput(
            labelText: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                widget.user.email = value;
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
            value: widget.user.email,
          ),
          const SizedBox(height: 10),
          MyDateField(
            labelText: 'Fecha de nacimiento',
            selectedDate: widget.user.fechaNac,
            onChanged: (value) {
              setState(() {
                widget.user.fechaNac = value;
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
                      widget.user.telefono = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    // Aquí puedes agregar una validación de formato de teléfono si lo deseas
                    return null; // Sin errores de validación
                  },
                  value: widget.user.telefono,
                ),
              ),
              const SizedBox(width: 2.5),
              Expanded(
                child: MyInput(
                  labelText: 'Carnet (ID)',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      widget.user.carnet = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null; // Sin errores de validación
                  },
                  value: widget.user.carnet,
                ),
              ),
            ],
          ),
          widget.paciente
              ? const SizedBox(height: 10)
              : const SizedBox(height: 0),
          widget.paciente
              ? MyInput(
                  labelText: 'Contacto de emergencia',
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      widget.user.contactoEmerg = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    // Aquí puedes agregar una validación de formato de teléfono si lo deseas
                    return null; // Sin errores de validación
                  },
                  value: widget.user.contactoEmerg,
                )
              : const SizedBox(height: 0),
          widget.edit ? const SizedBox(height: 0) : const SizedBox(height: 10),
          widget.edit
              ? const SizedBox(height: 0)
              : MyDropdown<String>(
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
                  value: widget.user.group,
                  onChanged: (value) {
                    setState(() {
                      widget.user.group = value;
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
          if (widget.user.group == 'Pacientes')
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
              value: widget.user.role,
              onChanged: (value) {
                setState(() {
                  widget.user.role = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null; // Sin errores de validación
              },
            ),
          if (widget.user.group == 'Personal Médico')
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
              value: widget.user.role,
              onChanged: (value) {
                setState(() {
                  widget.user.role = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo es requerido';
                }
                return null; // Sin errores de validación
              },
            ),
          widget.paciente
              ? const SizedBox(height: 0)
              : const SizedBox(height: 10),
          widget.paciente
              ? MyInput(
                  labelText: 'Especialidad',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      widget.user.especialidad = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    // Aquí puedes agregar una validación de formato de teléfono si lo deseas
                    return null; // Sin errores de validación
                  },
                  value: widget.user.especialidad,
                )
              : const SizedBox(height: 0),
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
                  value: widget.user.sexo,
                  onChanged: (value) {
                    setState(() {
                      widget.user.sexo = value;
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
                  items: List<DropdownMenuItem<String>>.generate(
                    bloodTypes.length,
                    (index) {
                      String type = bloodTypes[index];
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    },
                  ),
                  value: widget.user.tipoSangre,
                  onChanged: (value) {
                    setState(() {
                      widget.user.tipoSangre = value;
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
            onPressed: () async {
              if (formKey.currentState!.validate() && !userService.isLoading) {
                await userService.updateUsuario(
                    widget.user, widget.user.id.toString(), widget.user.group!);
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

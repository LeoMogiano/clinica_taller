import 'dart:io';
import 'package:clinica_app_taller/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clinica_app_taller/models/models.dart';
import 'package:clinica_app_taller/services/services.dart';
import 'package:clinica_app_taller/widgets/widgets.dart';

class FacialScreen extends StatefulWidget {
  const FacialScreen({Key? key}) : super(key: key);

  @override
  _FacialScreenState createState() => _FacialScreenState();
}

class _FacialScreenState extends State<FacialScreen> {
  File? _imageFile;
  User? _identifiedUser;
  bool _isIdentifying = false;
  bool _identificationCompleted = false;
  final _facialService = FacialService();

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _identifyUser() async {
    if (_imageFile != null) {
      try {
        setState(() {
          _isIdentifying = true;
        });

        final identifiedUser = await _facialService.identifyUser(_imageFile!);
        setState(() {
          _identifiedUser = identifiedUser;
          _identificationCompleted = true;
          _isIdentifying = false;
        });

        // Aquí puedes realizar acciones adicionales con el usuario identificado
      } catch (e) {
        // Manejar errores
      }
    }
  }

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
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 18.0,
                                ),
                                child: Center(
                                  child: Text(
                                    'IDENTIFICACIÓN FACIAL',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              if (_imageFile != null)
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const SizedBox(height: 20),
                              if (_imageFile == null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: _selectImageFromGallery,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[700],
                                        ),
                                        child: const Icon(
                                          Icons.photo,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    InkWell(
                                      onTap: _takePhoto,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[700],
                                        ),
                                        child: const Icon(
                                          Icons.photo_camera,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 20),
                              if (_imageFile != null && _isIdentifying == true)
                                const CupertinoActivityIndicator(
                                  color: Color(0xFF085C9D),
                                ),
                              if (_imageFile != null && _isIdentifying == false)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_identificationCompleted == false)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _imageFile = null;
                                            _identificationCompleted = false;
                                          });
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFe11709),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(width: 40),
                                    if (_identificationCompleted == false)
                                      InkWell(
                                        onTap: () {
                                          _identifyUser();
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF085C9D),
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              if (_identificationCompleted == true &&
                                  _isIdentifying == false)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _imageFile = null;
                                          _identificationCompleted = false;
                                        });
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green[800],
                                        ),
                                        child: const Icon(
                                          Icons.replay_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    if (_identifiedUser != null)
                                      const SizedBox(width: 40),
                                    if (_identifiedUser != null)
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => ShowFScreen(
                                                user: _identifiedUser!,
                                              ),
                                            ),
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
                                            Icons.medical_information_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              const SizedBox(height: 30),
                              if (_identificationCompleted &&
                                  _identifiedUser == null)
                                const Text('NO SE ENCONTRO NINGUN USUARIO.'),
                              if (_identifiedUser != null)
                                Text(
                                    'Usuario identificado: ${_identifiedUser!.name}'),
                            ],
                          ),
                        ),
                      ),
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

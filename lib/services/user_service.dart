import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clinica_app_taller/models/models.dart';

class UserService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  List<User> personalMed = [];
  List<User> pacientes = [];
  
  bool _isLoading = false; // Utiliza una variable privada para almacenar el estado de isLoading

  bool get isLoading => _isLoading; // Getter para obtener el valor de isLoading


  UserService() {
    getPersonalMed();
    getPacientes();
  }

  Future<List<User>> getPersonalMed() async {
    _isLoading = true; // Actualiza el valor de isLoading a true
    notifyListeners();

    try {
      final url = '$_baseUrl/api/personal_med';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<User> personal = User.parseUsers(response.body);
        personalMed = personal;
        return personal;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error en cargar los datos de personal médico');
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir
      print('Error al realizar la solicitud: $e');
      throw Exception('Error en cargar los datos de personal médico');
    } finally {
      _isLoading = false; // Actualiza el valor de isLoading a false
      notifyListeners();
    }
  }

  Future<List<User>> getPacientes() async {
    _isLoading = true; // Actualiza el valor de isLoading a true
    notifyListeners();

    try {
      final url = '$_baseUrl/api/pacientes';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<User> personal = User.parseUsers(response.body);
        pacientes = personal;
        return personal;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error en cargar los datos de los pacientes');
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir
      print('Error al realizar la solicitud: $e');
      throw Exception('Error en cargar los datos de los pacientes');
    } finally {
      _isLoading = false; // Actualiza el valor de isLoading a false
      notifyListeners();
    }
  }

  Future<void> createUsuario(User user, String password, String group) async {
    final url = '$_baseUrl/api/create_user';
    final headers = <String, String>{'Content-Type': 'application/json'};

    _isLoading = true;
    notifyListeners();

    try {
      // Crear un mapa JSON con los datos del usuario
      final userData = user.toMap();

      // Agregar el campo 'password' al mapa JSON si se proporciona
      userData['password'] = password;

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(userData),
      );

      if (response.statusCode == 201) {
        // El usuario se creó correctamente
        final newUser = user;

        if (group == 'Personal Médico') {
          personalMed.add(newUser);
        } else if (group == 'Pacientes') {
          pacientes.add(newUser);
        }

        print('Usuario creado exitosamente');
      } else if (response.statusCode == 400) {
        // Ocurrió un error de validación
        print('Error de validación: ${response.body}');
      } else {
        // Ocurrió un error desconocido
        print('Error al crear el usuario');
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir
      print('Error al realizar la solicitud: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateUsuario(User user, String id, String group) async {
    final url = '$_baseUrl/api/update_user/$id';
    final headers = <String, String>{'Content-Type': 'application/json'};

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        // El usuario se actualizó correctamente
        if (group == 'Personal Médico') {
          final index = personalMed.indexWhere((u) => u.id == id);
          if (index != -1) {
            personalMed[index] = user;
          }
        } else if (group == 'Pacientes') {
          final index = pacientes.indexWhere((u) => u.id == id);
          if (index != -1) {
            pacientes[index] = user;
          }
        }
        print('Usuario actualizado exitosamente');
      } else if (response.statusCode == 404) {
        // El usuario no fue encontrado
        print('Usuario no encontrado');
      } else if (response.statusCode == 400) {
        // Ocurrió un error de validación
        print('Error de validación: ${response.body}');
      } else {
        // Ocurrió un error desconocido
        print('Error al actualizar el usuario');
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir
      print('Error al realizar la solicitud: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}

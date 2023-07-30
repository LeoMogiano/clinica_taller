import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clinica_app_taller/models/models.dart';

class EmergencyService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  List<Emergency> emergencies = [];
  List<Analisis> analisis = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? paciente;
  User? medico;

  EmergencyService() {
    getEmergencies();
  }

  Future<List<Emergency>> getEmergencies() async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = '$_baseUrl/api/emergencias';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<Emergency> parsedEmergencies =
            Emergency.parseEmergencies(response.body);
        emergencies = parsedEmergencies;

        return parsedEmergencies;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error al cargar los datos de emergencias');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      throw Exception('Error al cargar los datos de emergencias');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Emergency> getEmergencyById(int id) async {
    final url = '$_baseUrl/api/emergencia/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final Emergency emergency = Emergency.fromMap(jsonData);

      return emergency;
    } else {
      throw Exception('Error al cargar los datos de la emergencia');
    }
  }

  Future<User> getUsuarioById(String id) async {
    final url = '$_baseUrl/api/user/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      /* _isLoading = true;
      notifyListeners(); */
      final Map<String, dynamic> userData = json.decode(response.body);
      final User user = User.fromMap(userData['user']);
      paciente = user;
      /* _isLoading = false;
      notifyListeners(); */
      return user;
    } else if (response.statusCode == 404) {
      throw Exception('Usuario no encontrado');
    } else {
      throw Exception('Error al obtener el usuario');
    }
  }

  Future<List<User>> loadMedicPac(String pacienteId, String medicoId) async {
    final List<User> medicPac = [];

    final paciente = await getUsuarioById(pacienteId);
    final medico = await getUsuarioById(medicoId);

    medicPac.add(paciente);
    medicPac.add(medico);

    return medicPac;
  }

  Future<void> createEmergencia(Emergency emergency) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = '$_baseUrl/api/create_emergencia';
      final Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };

      final emergencyData = emergency.toJson();

      final response = await http.post(Uri.parse(url),
          headers: headers, body: emergencyData);

      if (response.statusCode == 201) {
        final Emergency newEmergencia = emergency;
        emergencies.add(newEmergencia);
        print('Emergencia creada exitosamente');
      } else {
        final errors = json.decode(response.body)['errors'];
        // Manejar los errores de validación devueltos por Laravel
        print('Error al crear la emergencia: $errors');
        print('Cuerpo de la respuesta: ${response.body}');
        throw Exception('Error al crear la emergencia');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');

      // Imprimir la respuesta completa en caso de error
      if (e is http.Response) {
        print('Respuesta completa: ${e.toString()}');
      }

      throw Exception('Error al crear la emergencia');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateEmergencia(String id, Emergency emergency) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = '$_baseUrl/api/update_emergencia/$id';
      final Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };

      final emergencyData = emergency.toJson();

      final response =
          await http.put(Uri.parse(url), headers: headers, body: emergencyData);

      if (response.statusCode == 200) {
        final updatedEmergencia = emergency;
        // Actualizar la emergencia existente en la lista de emergencias
        final index = emergencies.indexWhere((e) => e.id.toString() == id);
        if (index != -1) {
          emergencies[index] = updatedEmergencia;
        }
        print('Emergencia actualizada exitosamente');
      } else {
        final errors = json.decode(response.body)['errors'];
        // Manejar los errores de validación devueltos por Laravel
        print('Error al actualizar la emergencia: $errors');
        print('Cuerpo de la respuesta: ${response.body}');
        throw Exception('Error al actualizar la emergencia');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');

      // Imprimir la respuesta completa en caso de error
      if (e is http.Response) {
        print('Respuesta completa: ${e.toString()}');
      }

      throw Exception('Error al actualizar la emergencia');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Analisis>> getAnalisisByEmergency(int id) async {
    try {
      final url = '$_baseUrl/api/analisis/emergencia/$id';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<Analisis> analisisTemp =
            Analisis.parseAnalisisList(response.body);
        analisis = analisisTemp;
        return analisis;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error en cargar los datos de analisis');
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir
      print('Error al realizar la solicitud: $e');
      throw Exception('Error en cargar los datos de analisis');
    } finally {}
  }

  Future<void> deleteAnalisis(int id) async {
    try {
      final url = '$_baseUrl/api/delete_analisis/$id';
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Analisis eliminado exitosamente
        print('Análisis eliminado exitosamente');
        // Remover el análisis de la lista analisis
        analisis.removeWhere((a) => a.id == id);
      } else if (response.statusCode == 404) {
        throw Exception('Análisis no encontrado');
      } else {
        throw Exception('Error al eliminar el análisis');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');

      // Imprimir la respuesta completa en caso de error
      if (e is http.Response) {
        print('Respuesta completa: ${e.toString()}');
      }

      throw Exception('Error al eliminar el análisis');
    } finally {}
  }

  Future<void> createAnalisis(Analisis analisys) async {
    try {
      final url = '$_baseUrl/api/create_analisis';
      final Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };

      final analisisData = analisys.toJson();

      final response =
          await http.post(Uri.parse(url), headers: headers, body: analisisData);

      if (response.statusCode == 201) {
        print('Análisis creado exitosamente');
        analisis.add(analisys);
      } else {
        final errors = json.decode(response.body)['errors'];
        // Manejar los errores de validación devueltos por Laravel
        print('Error al crear el análisis: $errors');
        print('Cuerpo de la respuesta: ${response.body}');
        throw Exception('Error al crear el análisis');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');

      // Imprimir la respuesta completa en caso de error
      if (e is http.Response) {
        print('Respuesta completa: ${e.toString()}');
      }

      throw Exception('Error al crear el análisis');
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clinica_app_taller/models/models.dart';

class EmergencyService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  List<Emergency> emergencies = [];
  bool isLoading = false;

  User? paciente;
  User? medico;

  EmergencyService() {
    getEmergencies();
  }

  Future<List<Emergency>> getEmergencies() async {
    final url = '$_baseUrl/api/emergencias';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      isLoading = true;
      notifyListeners();

      final List<Emergency> parsedEmergencies =
          Emergency.parseEmergencies(response.body);
      emergencies = parsedEmergencies;

      isLoading = false;
      notifyListeners();

      return parsedEmergencies;
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Error al cargar los datos de emergencias');
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
      isLoading = true;
      notifyListeners();
      final Map<String, dynamic> userData = json.decode(response.body);
      final User user = User.fromMap(userData['user']);
      paciente = user;
      isLoading = false;
      notifyListeners();
      return user;
    } else if (response.statusCode == 404) {
      throw Exception('Usuario no encontrado');
    } else {
      throw Exception('Error al obtener el usuario');
    }
  }

  
}
